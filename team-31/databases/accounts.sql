CREATE TABLE accounts (
  username TEXT NOT NULL PRIMARY KEY,
  name     TEXT NOT NULL,
  UNIQUE (username, name)
);

CREATE TABLE account_email (
  username TEXT NOT NULL REFERENCES accounts (username),
  email    TEXT,
  PRIMARY KEY (username, email)
);

CREATE TABLE account_phone (
  username TEXT NOT NULL REFERENCES accounts (username),
  phone    TEXT,
  PRIMARY KEY (username, phone)
);

CREATE TABLE account_address (
  username TEXT NOT NULL REFERENCES accounts (username),
  address  TEXT,
  PRIMARY KEY (username, address)
);

CREATE TABLE account_location (
  username TEXT NOT NULL REFERENCES accounts (username),
  location TEXT,
  PRIMARY KEY (username, location)
);

CREATE TABLE account_postcode (
  username TEXT NOT NULL REFERENCES accounts (username),
  postcode TEXT,
  PRIMARY KEY (username, postcode)
);

CREATE TABLE status (
  status_id INTEGER NOT NULL PRIMARY KEY,
  status    TEXT    NOT NULL,
  UNIQUE (status_id, status)
);

CREATE TABLE account_status (
  username  TEXT    NOT NULL REFERENCES accounts (username),
  status_id INTEGER NOT NULL REFERENCES status (status_id),
  PRIMARY KEY (username, status_id)
);

INSERT INTO status (status_id, status) VALUES
  (1, 'Admin'),
  (2, 'Loyal'),
  (3, 'Regular');
