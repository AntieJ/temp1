# README

## Requirement

Ruby 3.0.1
PostgreSQL 8.4 or later

## Setup

Installing dependencies
```bash
bundle install
```

Setting up databases
```bash
bundle exec rake db:setup
```

Starting the app
```bash
bundle exec rails s
```

Running all tests
```bash
bundle exec rspec
```

### Setting up with Docker

Building and starting app
```bash
docker-compose build
docker-compose up -d
```

Setting up databases
```bash
docker-compose run web rake db:setup
```

Running all tests
```bash
docker-compose run web rspec
```

## API

### List Campaigns

- **URL**
  /api/v1/campaigns

- **METHOD**
  `GET`

- **URL Params**

    *Required*: None.

    *Optional*:

  - Filter campaings by sector
    `sector=STRING`

  - Filter campaigns by investor size (range)
    `investments_count[from]=INTEGER`
    `investments_count[to]=INTEGER`

- **Data Params**

  None.

- **Success Response**

  Code: 200
  Content:
  ```
  {
    "data": [
      {
          "id": "1",
          "type": "campaign",
          "attributes": {
              "name": "Howell Inc",
              "image_url": "https://loremflickr.com/300/300/company",
              "percentage_raised": "0.0",
              "target_amount": "746551.42",
              "sector": "Computer & Network Security",
              "country": "BA",
              "investment_multiple": "6.13"
          }
      },
      {
          "id": "2",
          "type": "campaign",
          "attributes": {
              "name": "Harber-Morissette",
              "image_url": "https://loremflickr.com/300/300/company",
              "percentage_raised": "0.0",
              "target_amount": "428199.78",
              "sector": "Marketing and Advertising",
              "country": "JO",
              "investment_multiple": "6.03"
          }
      },
    ]
  }
  ```

### Create Investment

- **URL**
  /api/v1/campaigns/:campaign_id/investments

- **METHOD**
  `POST`

- **URL Params**

  *Required*: None.

  *Optional*: None.

- **Data Params**

    ```
    {
        "investment": { 
            "amount": DECIMAL
        }
    }
    ```

- **Success Response**

  Code: 200
  Content:
  ```
  {
    "data": {
      "id": "1",
      "type": "investment",
      "attributes": {
          "amount": "613.0"
      }
    }
  }
  ```
  
- **Error Response**

  Code: 404
  Content:
  ```
  {
    "message": "Couldn't find Campaign with 'id'=0"
  }
  ```
  
  or
  
  Code: 422
  Content:
  ```
  {
    "message": ['Validation error message']
  }
  ```
  
