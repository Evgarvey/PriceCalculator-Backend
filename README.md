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

## Database Schema (Draft)

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

### Items
```sql
list_items
  - id: integer
  - list_id: integer (foreign key)
  - name: string
  - price: decimal
  - quantity: integer
  - created_at: datetime
  - updated_at: datetime
```

## Development

Currently in initial development phase. The following features are in progress:

- [ ] Implement user authentication system
- [ ] Create RESTful API endpoints
- [ ] Set up database models and relationships
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

## License

This project is licensed under the MIT License.
