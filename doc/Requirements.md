# Requirements: UniStore

- [Requirements: UniStore](#requirements-unistore)
  - [Database Schema \& Entity Descriptions](#database-schema--entity-descriptions)
    - [Entities](#entities)
    - [Attributes](#attributes)
    - [Logic](#logic)
  - [Requirements](#requirements)
    - [CRUD Operations (Create, Read, Update, Delete)](#crud-operations-create-read-update-delete)
    - [Constraints \& Data Integrity](#constraints--data-integrity)
    - [Joins](#joins)
    - [Views](#views)
    - [Subqueries \& Complex Filtering](#subqueries--complex-filtering)
    - [Aggregation \& Grouping](#aggregation--grouping)

## Database Schema & Entity Descriptions

### Entities

* **User**: Represents any student, faculty, or staff member.
* **Product**: Represents an item listed for sale.
* **Category**: A classification for products (e.g., Textbooks, Electronics, Furniture).
* **Transaction**: Records the exchange between a buyer and a seller.
* **Review**: Feedback left by a buyer for a seller after a completed transaction.


### Attributes

- **Categories**: id, name, description  
- **Users**: id, first_name, last_name, email, password_hash, campus_location, created_at  
- **Products**: id, seller_id (FK), category_id (FK), title, description, price, status, created_at  
- **Transactions**: id, product_id (FK), buyer_id (FK), seller_id (FK), transaction_date, final_price  
- **Reviews**: id, transaction_id (FK), rating, comment, created_at


### Logic

* A **User** can list multiple **Products** (One-to-Many).
* A **Product** belongs to exactly one **Category** (Many-to-One).
* A **Transaction** involves one **Product**, one **Buyer (User)**, and one **Seller (User)**.
* A **Review** is linked to a specific **Transaction** (One-to-One).


## Requirements

The company requires severl workflows, that the system architect has analyzed. 
Ensure that the following works.

### CRUD Operations (Create, Read, Update, Delete)
*   **Create**: Insert a new user into the `Users` table and then list a "Calculus Textbook" under their `user_id` in the `Products` table.
*   **Read**: Retrieve all products that are currently marked as 'available' and have a price less than 50.00.
*   **Update**: Change the status of a specific `product_id` from 'available' to 'reserved' when a student expresses interest.
*   **Delete**: Remove a review from the `Reviews` table if it contains inappropriate language (simulated by `review_id`).

### Constraints & Data Integrity
*   **Unique Email Check**: Attempt to insert a user with an email address that already exists and observe the `UNIQUE` constraint violation.
*   **Transaction Validation**: Write a query (or a pseudo-trigger logic) that ensures a transaction cannot be created for a product that is already marked as 'sold'.
*   **Rating Boundary**: Attempt to insert a review with a rating of 6 and verify that the `CHECK` constraint (if supported) prevents the entry.

### Joins
*   **Inner Join**: Write a query to display the `title` of a product along with the `first_name` and `email` of the seller.
*   **Multi-Table Join**: Generate a "Sales Report" that shows the `transaction_id`, the buyer's `email`, the seller's `email`, and the `final_price` by joining `Transactions` with the `Users` table twice.
*   **Left Join**: List all `Categories` and the number of products in each, including categories that currently have zero products listed.

### Views
*   **AvailableMarketplace**: Create a view that only shows the `title`, `price`, and `category_name` for products that are currently 'available'.
*   **SellerRatings**: Create a view that calculates the average `rating` for each user based on the reviews received through their transactions.
*   **RecentTransactions**: Create a view that shows the 10 most recent transactions, including the product title and the date of the exchange.

### Subqueries & Complex Filtering
*   **Correlated Subquery**: Find all users who have never listed a product for sale (where the user ID does not exist in the `Products` table).
*   **Nested Subquery**: Retrieve the details of the product(s) with the highest `final_price` recorded in the `Transactions` table.
*   **In-Operator**: List all products belonging to categories that have the word "Electronics" or "Digital" in their description.

### Aggregation & Grouping
*   **Revenue by Category**: Calculate the total revenue generated (sum of `final_price`) for each category by joining `Transactions`, `Products`, and `Categories`.
*   **Top Sellers**: Identify the top 3 sellers by the count of 'sold' products, but only include those who have an average rating above 4.0.
*   **Campus Activity**: Group users by `campus_location` and count how many active listings are currently available in each area.

