# Exam App API documentation
This API is for student to access tests and save test results, you need use the Token endpoint to get a access token, and pass it in the header "Authorization", with all following requests.

the '*' at the paramater end indicate required

## Login

```http
POST /api/v1/users/login
```

| Parameter | Type
| :--- | :---
| `email*` | `string`
| `password*` | `string`

### Responses

```javascript
{
  "token" : string,
  "success" : true,
}

or

{
  "error" : string,
}

```


## Logout

```http
DELETE /api/v1/users/logout
```
### Responses

```javascript
{
  "success" : true,
}

or

{
  error: string
}
```



## Get tests
```http
GET /api/v1/tests
```
### Responses

```javascript
{
  tests: [
    {name: String, description: String }
  ]
}
```

## Get test
```http
GET /api/v1/test/:id
```
### Responses

```javascript
{
  id: Number,
  name: String,
  description: String,
  questions: [
    {
      id: Number,
      name: String,
      description: String,
      options: []
    }
  ]

}
```


## Save test results

```http
POST /api/v1/test/:id/save_results
```

### Parameter
note the test id is passed in the url
```json
{
  answers: [{question_id: Number, answer_option_id: Number}]
}

```
### Responses

```javascript
{
  success: true
}

or

{
  error: string
}
```
