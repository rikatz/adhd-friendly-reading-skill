# Example 3 — Code review

**Prompt:** "Review this PR that adds a discount endpoint."

---

## Before (conventional answer)

Overall the PR looks reasonable and the tests are a good start, but there are some issues. In `discounts/handler.py` the `apply_discount` function reads `order.total`, computes the new total and then saves it, but there is no locking, so two concurrent requests applying different codes can both read the same total and the last write wins, which means a customer could apply two codes that should be mutually exclusive; you should use `SELECT ... FOR UPDATE` or an optimistic version column. Also the endpoint `POST /orders/{id}/discount` doesn't check that the order belongs to the authenticated user, it only checks that the user is logged in, so any user can apply discounts to anyone's order if they guess the ID, and IDs are sequential integers. The percentage is computed with floats (`total * (1 - pct / 100)`), which will produce rounding errors like 19.999999 — use `Decimal` and quantize to 2 places with `ROUND_HALF_UP`. Minor: the constant `MAX_DISCOUNT = 50` should probably come from config, and the test `test_apply_discount` only covers the happy path; add tests for expired codes and for the 50% cap. The error messages are clear and the use of the existing `DiscountCode` model is nice.

---

## After (AFRS format)

**Summary:** The PR looks reasonable overall, but 2 issues should block merging: a missing ownership check lets any user discount anyone's order, and a race condition allows mutually exclusive codes to be combined. Float rounding should also be fixed.

### Blocking

#### 1. Any logged-in user can discount any order — `POST /orders/{id}/discount`

**What:** `POST /orders/{id}/discount` checks that the user is logged in, but not that the order belongs to them.

**Why it matters:** order IDs are sequential integers, so they are easy to guess. As a result, any user can apply discounts to other people's orders.

**Fix:** check that the order belongs to the authenticated user before applying the discount.

#### 2. Concurrent requests can combine exclusive codes — `apply_discount`

**What:** `apply_discount` reads `order.total`, computes the new total and saves it, with no locking.

**Why it matters:** two concurrent requests with different codes can both read the same total. The last write wins, so a customer can end up with two codes that should be mutually exclusive.

**Fix:** use `SELECT ... FOR UPDATE`, or add an optimistic version column.

### Should fix

#### 3. Float math produces rounding errors

`total * (1 - pct / 100)` uses floats, which produces values like `19.999999`.

**Fix:** use `Decimal` and quantize to 2 places with `ROUND_HALF_UP`.

### Nits

- `MAX_DISCOUNT = 50` should probably come from config.
- `test_apply_discount` only covers the happy path. Add tests for expired codes and for the 50% cap.

### What is good

- Error messages are clear.
- Reusing the existing `DiscountCode` model is a good call.
- The tests are a good start; the gaps are listed under Nits.

---

## What changed, and why

- **The verdict comes first**, so the reader knows the stakes before the details.
- **Issues are ordered by severity, not by where they appeared.** The security issue was buried mid-paragraph in the original.
- **Each issue follows What → Why it matters → Fix.** The consequence is written out instead of left for the reader to infer.
- **Nothing was removed.** Every finding, identifier and suggestion from the original is still present. The only additions are the explicit verdict, the severity grouping (Blocking / Should fix / Nits), and a Fix line for issue 1 that states the fix the original implied.
