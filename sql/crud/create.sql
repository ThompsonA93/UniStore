CREATE TYPE product_status AS ENUM ('available', 'reserved', 'sold');

CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    campus_location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    seller_id INTEGER NOT NULL REFERENCES Users(id) ON DELETE CASCADE,
    category_id INTEGER NOT NULL REFERENCES Categories(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    status product_status DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Transactions (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES Products(id),
    buyer_id INTEGER NOT NULL REFERENCES Users(id),
    seller_id INTEGER NOT NULL REFERENCES Users(id),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    final_price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_different_parties CHECK (buyer_id <> seller_id)
);

CREATE TABLE Reviews (
    id SERIAL PRIMARY KEY,
    transaction_id INTEGER UNIQUE NOT NULL REFERENCES Transactions(id),
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);