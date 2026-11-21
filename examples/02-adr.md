# Example 2 — ADR (Architecture Decision Record)

**Prompt:** "Write an ADR for moving our session storage from in-memory to Redis."

---

## Before (conventional answer)

### ADR 014: Session storage

#### Context

Currently sessions are stored in memory in each instance of the `web-api` service, which worked when we ran a single instance but now that we run 6 instances behind the load balancer we rely on sticky sessions configured in the ALB, and this causes uneven load distribution (one instance regularly reaches 85% CPU while others are at 30%), sessions are lost on every deploy because instances are replaced, forcing users to log in again, and autoscaling down also drops sessions. We considered keeping sticky sessions and accepting the issues, using signed JWT cookies with no server-side state, storing sessions in PostgreSQL, and using Redis via ElastiCache. JWTs would remove state but make revocation hard, which security requires for the "log out of all devices" feature, and the cookie would grow beyond 4 KB with the current session payload. PostgreSQL would work but adds roughly 2 reads per request to the primary database, which is already our bottleneck. Redis adds a new component to operate but has sub-millisecond reads, native TTL for expiry, and supports revocation by deleting keys.

#### Decision

We will use Redis (ElastiCache, cluster mode disabled, one replica) with the `connect-redis` store, a TTL of 24 hours refreshed on activity, and we will remove sticky sessions from the ALB once migration is complete.

#### Consequences

Load will be balanced evenly and deploys will no longer log users out, revocation becomes possible, but we add an infrastructure dependency with an estimated cost of USD 120/month, Redis becomes a single point of failure for authentication so we need the replica and an alarm on `ReplicationLag` and `CurrConnections`, and existing sessions will be lost once during cutover, which we will schedule for Sunday 03:00 UTC.

---

## After (AFRS format)

### ADR-014: Store sessions in Redis instead of instance memory

**Status:** Proposed

**Date:** YYYY-MM-DD

**Summary:** We will move sessions from each `web-api` instance's memory to Redis (ElastiCache). This fixes uneven load, logouts on deploy and the lack of session revocation. The cost is a new infrastructure dependency (about USD 120/month) that becomes critical for authentication.

#### Context

Sessions currently live **in memory** inside each `web-api` instance. That worked with one instance. We now run 6 instances behind the load balancer, so we rely on **sticky sessions** configured in the ALB.

Keeping sessions in instance memory, with sticky sessions to route users, causes three problems:

- **Uneven load:** one instance regularly reaches 85% CPU while others sit at 30%.
- **Logouts on deploy:** instances are replaced on every deploy, so their sessions disappear and users must log in again.
- **Logouts on scale-down:** autoscaling removes instances, and their sessions go with them.

#### Options considered

| Option | Pros | Cons |
| --- | --- | --- |
| Keep sticky sessions | — | All three problems remain |
| Signed JWT cookies (no server state) | No session store at all | Revocation is hard, and security requires it for "log out of all devices"; the cookie would exceed 4 KB with the current payload |
| PostgreSQL | Would work | Adds ~2 reads per request to the primary database, which is already the bottleneck |
| **Redis (ElastiCache)** | Sub-millisecond reads; native TTL for expiry; revocation by deleting keys | A new component to operate |

#### Decision

Use **Redis on ElastiCache** (cluster mode disabled, one replica) with the `connect-redis` store.

- Session TTL: 24 hours, refreshed on activity.
- Remove sticky sessions from the ALB once migration is complete.

#### Consequences

**Positive**

- Load is balanced evenly across instances.
- Deploys no longer log users out.
- Session revocation becomes possible, which unblocks "log out of all devices".

**Negative**

- New infrastructure dependency, estimated at USD 120/month.
- Redis becomes a single point of failure for authentication. Because of that, we keep the replica and add alarms on `ReplicationLag` and `CurrConnections`.
- Existing sessions are lost once during cutover.

**Follow-up work**

- [ ] Schedule cutover for Sunday 03:00 UTC.
- [ ] Create alarms for `ReplicationLag` and `CurrConnections`.
- [ ] Remove ALB sticky sessions after migration.

---

## What changed, and why

- **Title states the decision**, so the ADR list itself is readable.
- **Summary gives decision, reason and cost** in three sentences.
- **The three problems became a list:** they are parallel items. The reasoning for each option went into a table, so options can be compared on the same attributes.
- **Consequences are split by sign**, and the operational tasks hidden in prose became a checklist.
- **No facts were removed:** every number, setting and identifier is identical.
- **Template fields added:** `Status` and `Date` come from the ADR template; the date is a placeholder to fill in.
