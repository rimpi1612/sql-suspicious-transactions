drop table if exists card_holder;
drop table if exists credit_card;
drop table if exists merchant_category;
drop table if exists merchant;
drop table if exists transaction;

CREATE TABLE "card_holder" (
    "holder_id" int   NOT NULL,
    "holder_name" varchar(250)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "holder_id"
     )
);

CREATE TABLE "credit_card" (
    "card_number" varchar(250)   NOT NULL,
    "cardholder_id" int   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "card_number"
     )
);

CREATE TABLE "merchant_category" (
    "merchant_category_id" int   NOT NULL,
    "merchant_category_name" varchar(250)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "merchant_category_id"
     )
);

CREATE TABLE "merchant" (
    "merchant_id" int NOT NULL,
    "merchant_name" varchar(250)  NOT NULL,
    "merchant_category_id" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "merchant_id"
     )
);

CREATE TABLE "transaction" (
    "transaction_id" int   NOT NULL,
    "transaction_datetime" timestamp   NOT NULL,
    "amount" decimal   NOT NULL,
    "card_number" varchar(250)   NOT NULL,
    "merchant_id" int   NOT NULL,
    CONSTRAINT "pk_transaction" PRIMARY KEY (
        "transaction_id"
     )
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "card_holder" ("holder_id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_merchant_category_id" FOREIGN KEY("merchant_category_id")
REFERENCES "merchant_category" ("merchant_category_id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card_number" FOREIGN KEY("card_number")
REFERENCES "credit_card" ("card_number");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_merchant_id" FOREIGN KEY("merchant_id")
REFERENCES "merchant" ("merchant_id");

INSERT INTO card_holder VALUES
    (1, 'Robert Johnson'),
    (2, 'Shane Shaffer'),
    (3, 'Elizabeth Sawyer'),
    (4, 'Danielle Green'),
    (5, 'Sara Cooper'),
    (6, 'Beth Hernandez'),
    (7, 'Sean Taylor'),
    (8, 'Michael Floyd'),
    (9, 'Laurie Gibbs'),
    (10, 'Matthew Gutierrez'),
    (11, 'Brandon Pineda'),
    (12, 'Megan Price'),
    (13, 'John Martin'),
    (14, 'Gary Jacobs'),
    (15, 'Kyle Tucker'),
    (16, 'Crystal Clark'),
    (17, 'Michael Carroll'),
    (18, 'Malik Carlson'),
    (19, 'Peter Mckay'),
    (20, 'Kevin Spencer'),
    (21, 'Dana Washington'),
    (22, 'Austin Johnson'),
    (23, 'Mark Lewis'),
    (24, 'Stephanie Dalton'),
    (25, 'Nancy Contreras');

   INSERT INTO credit_card VALUES
    (3517111172421930, 1),
    (4761049645711555811, 1),
    (4866761290278198714, 2),
    (675911140852, 2),
    (30078299053512, 3),
    (4263694062533017, 4),
    (584226564303, 4),
    (4276466390111, 5),
    (4268491956169254, 5),
    (3581345943543942, 6),
    (4159836738768855913, 6),
    (3516952396080247, 7),
    (4539990688484983, 7),
    (4834483169177062, 8),
    (30063281385429, 8),
    (30181963913340, 9),
    (4962915017023706562, 10),
    (4165305432349489280, 10),
    (213193946980303, 10),
    (180098539019105, 11),
    (4644008655884311378, 11),
    (4027907156459098, 11),
    (501879657465, 12),
    (5297187379298983, 12),
    (376027549341849, 12),
    (4711773125020499, 13),
    (5135837688671496, 13),
    (3561954487988605, 13),
    (5175947111814778, 14),
    (4723783028106084756, 15),
    (6500236164848279, 15),
    (503842928916, 16),
    (5570600642865857, 16),
    (5500708021555307, 16),
    (6011987562414062, 17),
    (4498002758300, 18),
    (344119623920892, 18),
    (4743204091443101526, 19),
    (5361779664174555, 19),
    (3561072557118696, 19),
    (3535651398328201, 20),
    (4506405265172173, 20),
    (4586962917519654607, 20),
    (4279104135293225293, 21),
    (501809222273, 22),
    (4741042733274, 23),
    (4188164051171486, 23),
    (4150721559116778, 23),
    (4681896441519, 24),
    (30142966699187, 24),
    (3582198969197591, 24),
    (4319653513507, 25),
    (372414832802279, 25);
   
   INSERT INTO merchant_category VALUES
    (1, 'restaurant'),
    (2, 'coffee shop'),
    (3, 'bar'),
    (4, 'pub'),
    (5, 'food truck');
   
   INSERT INTO merchant VALUES
    (1, 'Murphy, Heath and Fields', 1),
    (2, 'Riggs-Adams', 1),
    (3, 'Sanders, Parks and Mcfarland', 2),
    (4, 'Mccarty-Thomas', 3),
    (5, 'Miller-Blevins', 4),
    (6, 'Wilson and Sons', 1),
    (7, 'Gomez-Kelly', 4),
    (8, 'Russell-Thomas', 1),
    (9, 'Curry, Scott and Richardson', 3),
    (10, 'Herrera Group', 1),
    (11, 'Stanton Group', 4),
    (12, 'Bell, Gonzalez and Lowe', 4),
    (13, 'Giles and Sons', 4),
    (14, 'Osborne-Page', 2),
    (15, 'Long, Harrell and Johnson', 5),
    (16, 'Bryant, Thomas and Collins', 4),
    (17, 'Bauer-Cole', 3),
    (18, 'Romero-Jordan', 5),
    (19, 'Santos-Fitzgerald', 4),
    (20, 'Kim-Lopez', 2),
    (21, 'Robertson-Smith', 4),
    (22, 'Dalton, Cameron and Jones', 3),
    (23, 'Wilson, Roberts and Davenport', 5),
    (24, 'Rodgers, Johnston and Macias', 5),
    (25, 'Vaughn, Wilson and Hall', 1),
    (26, 'Smith-Stephens', 2),
    (27, 'Horn Ltd', 2),
    (28, 'Hess-Fischer', 5),
    (29, 'Browning-Cantu', 4),
    (30, 'Atkinson Ltd', 3),
    (31, 'Fisher, Salazar and Thomas', 5),
    (32, 'Norton, Burton and Smith', 5),
    (33, 'Vasquez-Parker', 3),
    (34, 'Combs-Jones', 5),
    (35, 'Jarvis-Turner', 4),
    (36, 'Hamilton-Mcfarland', 1),
    (37, 'Nguyen, Bautista and Williams', 4),
    (38, 'Brown LLC', 3),
    (39, 'Young-Navarro', 5),
    (40, 'Cox, Montgomery and Morgan', 3),
    (41, 'Ford, Williams and Dunn', 4),
    (42, 'Kennedy-Chen', 3),
    (43, 'Wallace and Sons', 2),
    (44, 'Little-Floyd', 4),
    (45, 'Velazquez Ltd', 4),
    (46, 'Miller, Chavez and Cobb', 5),
    (47, 'Martin Inc', 1),
    (48, 'Baker Inc', 5),
    (49, 'Davis, Lowe and Baxter', 5),
    (50, 'Johnson-Watts', 1),
    (51, 'Fisher-Bolton', 1),
    (52, 'Jensen-Stanley', 5),
    (53, 'Wallace PLC', 4),
    (54, 'Berry-Lopez', 1),
    (55, 'Johnson, Rivas and Anderson', 1),
    (56, 'Smith PLC', 3),
    (57, 'Thornton-Williams', 4),
    (58, 'Young, Hull and Williams', 4),
    (59, 'Williams Group', 3),
    (60, 'Smith-Richards', 4),
    (61, 'Richardson, Smith and Jordan', 5),
    (62, 'Cooper, Carpenter and Jackson', 5),
    (63, 'Reed Group', 5),
    (64, 'Cline, Myers and Strong', 1),
    (65, 'Allen, Ramos and Carroll', 4),
    (66, 'Robles Inc', 3),
    (67, 'Maxwell, Tapia and Villanueva', 2),
    (68, 'Ramirez-Carr', 2),
    (69, 'Dominguez PLC', 5),
    (70, 'White-Hall', 3),
    (71, 'Greene LLC', 1),
    (72, 'Lopez-Kelly', 1),
    (73, 'Colon Ltd', 3),
    (74, 'Skinner-Williams', 4),
    (75, 'Martinez Group', 1),
    (76, 'Lowe PLC', 1),
    (77, 'Brown, Ballard and Glass', 1),
    (78, 'Ruiz-Anderson', 4),
    (79, 'Lee LLC', 1),
    (80, 'Kelly, Dyer and Schmitt', 5),
    (81, 'Fowler and Sons', 5),
    (82, 'Day-Murray', 5),
    (83, 'Solis Group', 5),
    (84, 'Marshall-Rojas', 2),
    (85, 'Patton-Rivera', 3),
    (86, 'Walker, Campbell and Sullivan', 5),
    (87, 'Griffin-Woodard', 3),
    (88, 'Armstrong PLC', 5),
    (89, 'Kelley-Roberts', 5),
    (90, 'Brown-Cunningham', 4),
    (91, 'Turner Ltd', 4),
    (92, 'Garcia-White', 4),
    (93, 'Rodriguez-Parker', 5),
    (94, 'Yoder-Zavala', 5),
    (95, 'Baxter-Smith', 1),
    (96, 'Johnson-Fuller', 4),
    (97, 'Ruiz-Chavez', 3),
    (98, 'Rivera PLC', 4),
    (99, 'Bond, Lewis and Rangel', 1),
    (100, 'Townsend-Anderson', 1),
    (101, 'Whitehead-Sexton', 4),
    (102, 'Walters-Ward', 1),
    (103, 'Jones, Clark and Hoover', 2),
    (104, 'Mcdaniel, Hines and Mcfarland', 2),
    (105, 'Garcia and Sons', 4),
    (106, 'Carter-Blackwell', 4),
    (107, 'Rowe-Abbott', 4),
    (108, 'Best Inc', 1),
    (109, 'Collins LLC', 2),
    (110, 'Rodriguez, Dunlap and Nunez', 2),
    (111, 'Padilla-Clements', 2),
    (112, 'Greer Inc', 3),
    (113, 'Edwards-Aguirre', 2),
    (114, 'Greene-Wood', 3),
    (115, 'Williams Inc', 4),
    (116, 'Ferguson Ltd', 2),
    (117, 'Mitchell Group', 2),
    (118, 'Maldonado Group', 2),
    (119, 'Henderson and Sons', 1),
    (120, 'Vega, Jones and Castro', 5),
    (121, 'Fleming, Smith and Collins', 3),
    (122, 'Perry and Sons', 3),
    (123, 'Boone, Davis and Townsend', 4),
    (124, 'Mccarty PLC', 1),
    (125, 'Russell and Sons', 4),
    (126, 'Bartlett and Sons', 4),
    (127, 'Williams, Wright and Wagner', 2),
    (128, 'Pitts, Salinas and Garcia', 2),
    (129, 'Sweeney-Paul', 2),
    (130, 'Brown, Estrada and Powers', 2),
    (131, 'Harrison, Newton and Hansen', 1),
    (132, 'Pugh-Williams', 3),
    (133, 'Scott, Hess and Finley', 3),
    (134, 'Jenkins, Peterson and Beck', 1),
    (135, 'Jacobs, Torres and Walker', 3),
    (136, 'Martinez-Robinson', 3),
    (137, 'Garcia PLC', 5),
    (138, 'Mccullough-Murphy', 5),
    (139, 'Kidd-Lopez', 5),
    (140, 'Wheeler-Moreno', 5),
    (141, 'Wood-Ramirez', 3),
    (142, 'Thomas-Garcia', 5),
    (143, 'Guzman, Garcia and Church', 3),
    (144, 'Walker, Deleon and Wolf', 1),
    (145, 'Hood-Phillips', 3),
    (146, 'Pitts, Smith and Gonzalez', 4),
    (147, 'Marshall-Lopez', 5),
    (148, 'Huerta, Keith and Walters', 5),
    (149, 'Clark and Sons', 5),
    (150, 'Johnson and Sons', 2);

-- transaction table data uploaded using csv export --
