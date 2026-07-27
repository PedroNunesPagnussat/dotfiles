# When to Mock

Mock at **system boundaries** only:

- External APIs (payment, email, etc.)
- Databases (sometimes - prefer test DB)
- Time/randomness
- File system (sometimes)

Never mock anything you control: your own modules, classes, and internal collaborators. That's mocking inside the seam.

## Designing for Mockability

At system boundaries, design interfaces that are easy to mock:

**1. Use dependency injection**

Pass external dependencies in rather than creating them internally:

```python
# Easy to mock
def process_payment(order, payment_client):
    return payment_client.charge(order.total)


# Hard to mock
def process_payment(order):
    client = StripeClient(os.environ["STRIPE_KEY"])
    return client.charge(order.total)
```

**2. Prefer SDK-style interfaces over generic fetchers**

Create specific functions for each external operation instead of one generic function with conditional logic:

```python
# GOOD: Each function is independently mockable
class Api:
    def get_user(self, id):
        return fetch(f"/users/{id}")

    def get_orders(self, user_id):
        return fetch(f"/users/{user_id}/orders")

    def create_order(self, data):
        return fetch("/orders", method="POST", body=data)


# BAD: Mocking requires conditional logic inside the mock
class Api:
    def fetch(self, endpoint, options=None):
        return fetch(endpoint, options)
```

Each mock then returns one specific shape, with no conditional logic in test setup, type safety per endpoint, and the test's setup showing at a glance which endpoints it exercises.