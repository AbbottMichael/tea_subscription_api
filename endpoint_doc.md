# Endpoints

<br>

HTTP Verb | Endpoint              | Description                              | Link
----------|-----------------------|------------------------------------------|---------------------------
POST       | `/api/v1/subscriptions` | Create a customer's new tea subscription | [Link](#post-subscriptions)
PATCH       | `/api/v1/subscriptions` | Edit an existing tea subscription | [Link](#patch-subscriptions)
GET       | `/api/v1/subscriptions` | Get all of a customer's subscriptions | [Link](#get-subscriptions) 


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
`tea_id`   | Integer | body | Required | The ID of the tea
`address_id`   | Integer | body | Required | The ID of the shipping address

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

<br>

## PATCH subscriptions

Edit an existing tea subscription

```
PATCH /api/v1/subscriptions/:id
```

### Parameters

Name            | Data Type | In    | Required/Optional    | Description
----------------|---------|-------|----------------------|------------
`subscription_id`   | Integer | uri | Required | The ID of the subscription

Notes:
-

### Example Request

```
PATCH http://localhost:3000/api/v1/subscriptions/1
```

### Example Body
```
{
    "status": "cancelled"
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
            "status": "cancelled",
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

<br>

## GET subscriptions

Get all of a customer's subscriptions

```
GET /api/v1/subscriptions?customer_id=
```

### Parameters

Name            | Data Type | In    | Required/Optional    | Description
----------------|---------|-------|----------------------|------------
`customer_id`   | Integer | query params | Required | The ID of the customer

Notes:
-

### Example Request

```
PATCH http://localhost:3000/api/v1/subscriptions?customer_id=1
```

### Example Response

```
Status: 200 OK
```

```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "status": "cancelled",
                "frequency": 30,
                "ounces": 2,
                "customer_id": 1,
                "tea_id": 1,
                "address_id": 1,
                "price": 800
            }
        }
    ]
}

```
---
