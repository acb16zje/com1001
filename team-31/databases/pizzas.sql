CREATE TABLE pizzas (
  pizza_id      INTEGER NOT NULL PRIMARY KEY,
  NAME          TEXT    NOT NULL,
  DESCRIPTION   TEXT    NOT NULL,
  allergen_info TEXT,
  image_path    TEXT    NOT NULL,
  UNIQUE (NAME, DESCRIPTION)
);

CREATE TABLE pizza_location (
  pizza_id INTEGER NOT NULL REFERENCES pizzas (pizza_id),
  location TEXT    NOT NULL,
  PRIMARY KEY (pizza_id, location)
);

CREATE TABLE pizza_pricing (
  pizza_id       INTEGER NOT NULL REFERENCES pizzas (pizza_id),
  price_category INTEGER NOT NULL REFERENCES pricing (price_category)
);

CREATE TABLE pizza_sold (
  pizza_id    INTEGER NOT NULL REFERENCES pizzas (pizza_id),
  location    TEXT    NOT NULL,
  amount_sold INTEGER NOT NULL
);

CREATE TABLE pricing (
  price_category INTEGER NOT NULL,
  size           TEXT    NOT NULL,
  price          FLOAT   NOT NULL,
  UNIQUE (price_category, size)
);

CREATE TABLE revenue (
  location TEXT  NOT NULL,
  revenue  FLOAT NOT NULL
);

INSERT INTO pricing (price_category, size, price) VALUES
  (1, 'Small', 8.99),
  (1, 'Medium', 11.99),
  (1, 'Large', 14.99),
  (2, 'Small', 10.99),
  (2, 'Medium', 14.99),
  (2, 'Large', 18.99);

INSERT INTO pizzas (pizza_id, name, description, allergen_info, image_path) VALUES
  (1, 'Pepperoni', 'Regular base with pepperoni topping', 'Gluten, milk',
   '/images/pizza/pepperoni.png'),
  (2, 'New Yorker', 'Pepperoni, ham, bacon, mushrooms', 'Gluten, milk',
   '/images/pizza/new_yorker.png'),
  (3, 'Margherita', 'Regular base with tomato and extra cheese', 'Gluten, milk',
   '/images/pizza/margherita.png'),
  (4, 'Mighty Meaty',
   'Tomato sauce, pepperoni, ham, ground beef, sausage, red onions, mushrooms and mozzarella cheese',
   'Gluten, milk, celery and mustard', '/images/pizza/sheffield/mighty_meaty.png'),
  (5, 'Texas BBQ',
   'BBQ sauce topped with smoky bacon, succulent roast chicken, red onions, green and red peppers',
   'Gluten, milk, sulphur dioxide', '/images/pizza/london/texas_bbq.png'),
  (6, 'Ham & Pineapple', 'Regular base with ham and pineapple toppings', 'Gluten, milk',
   '/images/pizza/ham_pineapple.png'),
  (7, 'Chicken Pepperoni', 'A mouth-watering combination of savoury chicken pepperoni and 100%' ||
   ' Mozzarella cheese. Always a treat!', 'Gluten, milk', '/images/pizza/chickenpepperoni.png'),
  (8, 'Curry Chicken', 'Italian classic meets local favourite. Chunky chicken, potatoes and' ||
   ' diced tomatoes come together for an authentic flavour of rich spices.',
   'Gluten, milk, sulphur dioxide', '/images/pizza/currychicken.png'),
  (9, 'Hawaiian', 'An all-time favourite. Tender chicken ham combined with sweet and succulent' ||
   ' pineapple chunks for a taste of the good old days.', 'Gluten, milk', '/images/pizza/hawaiian.png'),
  (10, 'Meat Galore', 'The perfect meat-lover’s choice. Chicken ham, pepperoni, minced beef and' ||
   ' cabanossi sausages, with a tomato mozzarella melt and a sprinkle of fresh basil.',
   'Gluten, milk, mustard, celery, sulphur dioxide', '/images/pizza/meatgalore.png'),
  (11, 'Super Supreme', 'Always a house favourite, combining juicy ground beef, smoky cabanossi' ||
   ' sausages, beef pepperoni, chicken ham, and a luscious mix of capsicums, onions, olives,' ||
   ' mushrooms and pineapple chunks.', 'Gluten, milk', '/images/pizza/supersupreme.png'),
  (12, 'Veggie Lover', 'A delightful combination of garden fresh onions, olives, capsicums and' ||
   ' mushrooms, sweetened with pineapple chunks and diced tomatoes.', 'Gluten, milk',
   '/images/pizza/veggielover.png'),
  (13, 'Chicken Alfredo', 'Succulent chicken breast, finely chopped basil, sweet olives, cherry' ||
   ' tomatoes and baby spinach, on a creamy Alfredo sauce.', 'Gluten, milk',
   '/images/pizza/sheffield/chickenalfredo.png'),
  (14, 'Fiery Trio Chicken', 'A combination of fiery chicken chunks, chicken ham and chicken' ||
   ' pepperoni in a spicy Buffalo sauce, for those who love a tinge of spice.', 'Gluten, milk, mustard',
   '/images/pizza/sheffield/fierytriochicken.png'),
  (15, 'Seafood Deluxe', 'Taste the freshness of the ocean in this combination of juicy prawns' ||
   ' marinated in spiced powder, succulent squid and tasty tuna.', 'Gluten, milk, prawn',
   '/images/pizza/sheffield/seafooddeluxe.png'),
  (16, 'Ranch Style Chicken', 'Tender sliced chicken breast, turkey bacon, and a medley of' ||
   ' button, shimeji and shiitake mushrooms on a bed of BBQ sauce, topped with mayonnaise drizzle.',
   'Gluten, milk, mustard, celery', '/images/pizza/london/ranchstylechicken.png'),
  (17, 'Shrimp & Spinach', 'A shrimp lover''s dream. Delightfully succulent spiced shrimps and' ||
   ' sweet pineapple rings baked in a blend of rich pesto and tomato sauce.', 'Gluten, milk, shrimp',
   '/images/pizza/london/shrimpnspinach.png'),
  (18, 'The Four Cheese', 'Send your tastebuds into a cheesy frenzy with a divine combination of' ||
   ' 4 cheeses – mozzarella, parmesan, cheddar and feta.', 'Gluten, milk',
   '/images/pizza/london/thefourcheese.png');

INSERT INTO pizza_pricing (pizza_id, price_category) VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 2),
  (5, 2),
  (6, 1),
  (7, 1),
  (8, 1),
  (9, 1),
  (10, 2),
  (11, 2),
  (12, 1),
  (13, 1),
  (14, 1),
  (15, 2),
  (16, 2),
  (17, 1),
  (18, 1);

INSERT INTO pizza_location (pizza_id, location) VALUES
  (1, 'Both'),
  (2, 'Both'),
  (3, 'Both'),
  (4, 'Sheffield'),
  (5, 'London'),
  (6, 'Both'),
  (7, 'Both'),
  (8, 'Both'),
  (9, 'Both'),
  (10, 'Both'),
  (11, 'Both'),
  (12, 'Both'),
  (13, 'Sheffield'),
  (14, 'Sheffield'),
  (15, 'Sheffield'),
  (16, 'London'),
  (17, 'London'),
  (18, 'London');

INSERT INTO pizza_sold (pizza_id, location, amount_sold) VALUES
  (1, 'Sheffield', 0),
  (1, 'London', 0),
  (2, 'Sheffield', 0),
  (2, 'London', 0),
  (3, 'Sheffield', 0),
  (3, 'London', 0),
  (4, 'Sheffield', 0),
  (5, 'London', 0),
  (6, 'Sheffield', 0),
  (6, 'London', 0),
  (7, 'Sheffield', 0),
  (7, 'London', 0),
  (8, 'Sheffield', 0),
  (8, 'London', 0),
  (9, 'Sheffield', 0),
  (9, 'London', 0),
  (10, 'Sheffield', 0),
  (10, 'London', 0),
  (11, 'Sheffield', 0),
  (11, 'London', 0),
  (12, 'Sheffield', 0),
  (12, 'London', 0),
  (13, 'Sheffield', 0),
  (14, 'Sheffield', 0),
  (15, 'Sheffield', 0),
  (16, 'London', 0),
  (17, 'London', 0),
  (18, 'London', 0);

INSERT INTO revenue (location, revenue) VALUES
  ('Sheffield', 0),
  ('London', 0);
