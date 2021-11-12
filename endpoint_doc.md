# Endpoints

<br>

HTTP Verb | Endpoint              | Description                              | Link
----------|-----------------------|------------------------------------------|---------------------------
POST       | `/api/v1/subscriptions` | Create a customer's new tea subscription | [Link](#post-subscriptions)
PATCH       | `/api/v1/subscriptions` | Edit an existing tea subscription |
GET       | `/api/v1/subscriptions` | Get all of a customer's subscriptions | 


---

<br>

## POST subscriptions

Create a customer's new tea subscription

```
POST /api/v1/subscriptions
```

### Parameters

Name            | Data Type | In    | Required/Optional    | Description
----------------|---------|-------|----------------------|------------
`customer_id`   | Integer | body | Required | The ID of the customer

Notes:
-

### Example Request

```
POST http://localhost:3000/api/v1/subscriptions
```

### Example Body
```
{
    "frequency": 30,
    "ounces": 2,
    "tea_id": 1,
    "customer_id": 1,
    "address_id": 1
}
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "status": "active",
            "frequency": 30,
            "ounces": 2,
            "customer_id": 1,
            "tea_id": 1,
            "address_id": 1,
            "price": 800
        }
    }
}

```
---
