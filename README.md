# Billionaire Shopping Spree Calculator API

Backend API service for the Billionaire Shopping Spree Calculator web application. This service handles data management, user authentication, and shopping list operations.

## Project Status

⚠️ **Note:** This project is currently in initial planning phase. The documentation below represents the planned implementation.

## Features (Planned)

- RESTful API endpoints for shopping list management
- User authentication system
- Database persistence for user data and shopping lists
- Secure password handling
- JSON API responses

## Technical Stack (Planned)

- Ruby on Rails
- SQLite database
- Active Record ORM
- JWT for authentication
- BCrypt for password hashing

## Setup

1. Ensure you have Ruby installed (version 3.0.0 or newer)
2. Clone the repository
3. Install dependencies:
   ```bash
   bundle install
   ```
4. Setup database:
   ```bash
   rails db:create
   rails db:migrate
   ```
5. Start the server:
   ```bash
   rails server
   ```

## API Endpoints (Draft)

The following endpoints are planned for the initial implementation:

### Authentication
- `POST /auth/signup` - Create new user account
- `POST /auth/login` - Authenticate user and receive JWT
- `POST /auth/logout` - Invalidate JWT

### Lists
- `GET /lists` - Retrieve user's shopping lists
- `POST /lists` - Create new shopping list
- `GET /lists/:id` - Get specific list details
- `PUT /lists/:id` - Update list
- `DELETE /lists/:id` - Delete list

### Items
- `GET /lists/:id/items` - Get items in a list
- `POST /lists/:id/items` - Add item to list
- `PUT /lists/:id/items/:item_id` - Update item
- `DELETE /lists/:id/items/:item_id` - Remove item from list

## Database Schema (Implemented)

### Users
```sql
users
  - id: integer
  - email: string
  - password_digest: string
  - created_at: datetime
  - updated_at: datetime
```

### Lists
```sql
shopping_lists
  - id: integer
  - user_id: integer (foreign key)
  - name: string
  - description: text
  - created_at: datetime
  - updated_at: datetime
```

### List Items
```sql
list_items
  - id: integer
  - list_id: integer (foreign key)
  - material_id: integer (foreign key)
  - quantity: decimal
  - created_at: datetime
  - updated_at: datetime
```

### Material Categories
```sql
material_categories
  - id: integer
  - name: string
  - base_unit: string
  - description: text
  - created_at: datetime
  - updated_at: datetime
```

### Materials
```sql
materials
  - id: integer
  - name: string
  - material_category_id: integer (foreign key)
  - created_at: datetime
  - updated_at: datetime
```

### Material Prices by Category

#### Currencies
```sql
currency_prices
  - id: integer
  - material_id: integer (foreign key)
  - usd_ratio: decimal
  - created_at: datetime
  - updated_at: datetime
```

#### Common Materials
```sql
common_material_prices
  - id: integer
  - material_id: integer (foreign key)
  - price_per_m3: decimal
  - density: decimal
  - created_at: datetime
  - updated_at: datetime
```

#### Liquids
```sql
liquid_prices
  - id: integer
  - material_id: integer (foreign key)
  - price_per_liter: decimal
  - density: decimal
  - created_at: datetime
  - updated_at: datetime
```

#### Precious Materials
```sql
precious_material_prices
  - id: integer
  - material_id: integer (foreign key)
  - price_per_gram: decimal
  - density: decimal
  - created_at: datetime
  - updated_at: datetime
```

## Development

Current development status:

- [x] Set up database models and relationships
- [ ] Implement user authentication system
- [ ] Create RESTful API endpoints
- [ ] Add request validation
- [ ] Implement error handling
- [ ] Add API documentation
- [ ] Set up testing environment
- [ ] Add rate limiting
- [ ] Implement CORS configuration

## Testing

Run the test suite:
```bash
rails test
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
