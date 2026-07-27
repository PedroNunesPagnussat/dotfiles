# Worked Examples

Each pair is the same behavior tested badly, then well.

## Through the seam, not the internals

```python
# BAD: asserts on a mocked internal collaborator's call
async def test_checkout_calls_payment_service_process(mocker):
    mock_payment = mocker.patch("app.payment_service")
    await checkout(cart, payment)
    mock_payment.process.assert_called_once_with(cart.total)


# GOOD: asserts on observable behavior, one logical assertion
async def test_user_can_checkout_with_valid_cart():
    cart = create_cart()
    cart.add(product)
    result = await checkout(cart, payment_method)
    assert result.status == "confirmed"
```

## Verify through the interface, not a side channel

```python
# BAD: bypasses the interface to check the database directly
async def test_create_user_saves_to_database():
    await create_user({"name": "Alice"})
    row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"])
    assert row is not None


# GOOD: verifies through the interface a caller would use
async def test_create_user_makes_user_retrievable():
    user = await create_user({"name": "Alice"})
    retrieved = await get_user(user.id)
    assert retrieved.name == "Alice"
```

## Independent expected value, not a recomputation

```python
# BAD: expected value is computed the way the code computes it
def test_calculate_total_sums_line_items():
    items = [{"price": 10}, {"price": 5}]
    expected = sum(i["price"] for i in items)
    assert calculate_total(items) == expected


# GOOD: expected value is a known-good literal
def test_calculate_total_sums_line_items():
    assert calculate_total([{"price": 10}, {"price": 5}]) == 15
```
