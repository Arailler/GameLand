--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Borrow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Borrow" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "gameId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deadline timestamp(3) without time zone NOT NULL,
    returned boolean DEFAULT false NOT NULL,
    "lastModified" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Borrow" OWNER TO postgres;

--
-- Name: Borrow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Borrow_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Borrow_id_seq" OWNER TO postgres;

--
-- Name: Borrow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Borrow_id_seq" OWNED BY public."Borrow".id;


--
-- Name: Game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Game" (
    id integer NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    age text NOT NULL,
    players text NOT NULL,
    quantity integer NOT NULL,
    "imageSrc" text NOT NULL,
    "tagLine" text NOT NULL,
    description text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastModified" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Game" OWNER TO postgres;

--
-- Name: Game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Game_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Game_id_seq" OWNER TO postgres;

--
-- Name: Game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Game_id_seq" OWNED BY public."Game".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "birthDate" timestamp(3) without time zone NOT NULL,
    country text NOT NULL,
    "postalCode" text NOT NULL,
    street text NOT NULL,
    number text NOT NULL,
    phone text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role text DEFAULT 'member'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastModified" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Borrow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow" ALTER COLUMN id SET DEFAULT nextval('public."Borrow_id_seq"'::regclass);


--
-- Name: Game id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Game" ALTER COLUMN id SET DEFAULT nextval('public."Game_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Borrow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Borrow" (id, "userId", "gameId", "createdAt", deadline, returned, "lastModified") FROM stdin;
1	1	8	2025-07-18 10:23:19.063	2025-08-17 10:23:19.054	f	2025-07-18 10:23:19.063
2	1	10	2025-07-18 10:23:35.982	2025-08-17 10:23:35.981	f	2025-07-18 10:23:35.982
3	1	6	2025-07-18 10:23:42.348	2025-08-17 10:23:42.347	f	2025-07-18 10:23:42.348
4	1	15	2025-07-18 10:23:48.441	2025-08-17 10:23:48.441	f	2025-07-18 10:23:48.441
5	1	23	2025-07-18 10:24:00.716	2025-08-17 10:24:00.715	f	2025-07-18 10:24:00.716
6	1	4	2025-07-23 13:01:32.819	2025-08-22 13:01:32.818	f	2025-07-23 13:01:32.819
\.


--
-- Data for Name: Game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Game" (id, name, category, age, players, quantity, "imageSrc", "tagLine", description, "createdAt", "lastModified") FROM stdin;
1	Tennis racket	sport	any	1	2	tennis_racket.jpg	Master your swing with this high-performance tennis racket.	A lightweight, durable tennis racket perfect for casual matches or intense practice. Whether you're a beginner or advanced player, this racket offers great control and power. Suitable for indoor or outdoor play, it’s your ideal companion on the court.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
2	Fairy warriors	video	12+	1	4	fairy_warriors.jpg	Enchanting battles await with magic-wielding fairy warrior heroines.	Step into a mystical realm where fairies fight dark forces. Control magical warriors with unique powers in a visually stunning action game. Explore enchanted lands, complete quests, and defeat powerful enemies in this fantasy adventure designed for young teens and up.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
3	Mekkanik jeep	build	8+	1+	3	mekkanik_jeep.jpg	Assemble your own rugged jeep from detailed mechanical parts.	This creative construction kit lets kids build a sturdy off-road jeep using realistic parts. Great for enhancing fine motor skills and logical thinking, it’s ideal for group play or solo building. Includes easy instructions and encourages hands-on engineering fun.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
5	Labyrinth	puzzle	any	1-6	4	labyrinth.jpg	Navigate twisting paths and find treasures in shifting mazes.	A classic maze game where players shift tiles to create new paths and collect treasures. Ideal for solo or team play, the game changes with every move, offering endless strategic possibilities. Great for family game night or rainy day challenges.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
7	Halloween puzzle	puzzle	any	1	4	halloween_puzzle.jpg	Spooky Halloween scenes come alive in this eerie puzzle.	Perfect for autumn nights, this detailed Halloween-themed puzzle features ghosts, pumpkins, and haunted houses. Challenging and fun for all ages, it promotes focus and visual thinking. Complete it solo or with others for a festive fright-filled experience.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
9	Jessy	figurine	3+	1	4	jessy.jpg	Meet Jessy, your new favorite magical forest friend.	Jessy is a beautifully detailed figurine with posable limbs and charming accessories. Perfect for imaginative storytelling and display, she fits right into magical playsets or toy collections. Safe and durable for ages 3 and up.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
11	Mega fighter	figurine	3+	1	5	mega_fighter.jpg	Power up your battles with the unstoppable Mega Fighter.	This action-packed figurine features articulated limbs, vibrant armor, and an epic weapon set. Ideal for imaginative play and heroic storytelling, Mega Fighter is ready to protect the universe—or your toy shelf. Safe for kids aged 3 and up.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
12	Fairy magic	board	6+	2-4	2	fairy_magic.jpg	Cast spells and race through enchanted forests with fairies.	A whimsical board game where players collect magical ingredients and cast spells to win. Designed for young children and families, it teaches turn-taking, strategy, and imaginative thinking through colorful components and charming fairy-world themes.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
13	Kinball ball	sport	any	1+	2	kinball_ball.jpg	Giant ball action for high-energy, inclusive team play fun.	This oversized, lightweight ball is designed for kin-ball, a dynamic sport that encourages teamwork and movement. Great for schools, groups, or backyard play, it’s a fantastic way to stay active and build coordination for all ages.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
14	Mahjong	puzzle	3+	1-8	5	mahjong.jpg	Match tiles, master patterns, and unlock ancient puzzle secrets.	A beautifully crafted Mahjong set perfect for players of all ages. Whether for solo tile-matching or traditional multiplayer rules, it’s great for developing pattern recognition, memory, and focus. Comes with sturdy tiles and a decorative storage box.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
16	Quiet	video	16+	1	4	quiet.jpg	A haunting, immersive experience in a world of silence.	Explore a desolate world where sound is dangerous. "Quiet" blends stealth, exploration, and psychological tension in a beautifully eerie game. Navigate through abandoned cities, uncover secrets, and survive without making a noise. A game of silence, shadows, and suspense.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
17	Dolphin light	card	6+	3	4	dolphin_light.jpg	Race dolphins, collect light pearls, and outsmart the tides.	A fast-paced card game featuring playful dolphins collecting magical light pearls. Designed for young kids and families, it encourages quick thinking and friendly competition. Colorful illustrations and simple rules make it ideal for engaging play and early strategic skills.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
18	Football ball	sport	any	1+	5	football_ball.jpg	Kick, pass, score—perfect for every backyard football match.	A durable, regulation-size football designed for fun and serious play. Ideal for schools, parks, or casual games, it features a textured grip and long-lasting material. Great for improving coordination and encouraging active, outdoor play for all ages.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
19	Thunder ring	video	12+	1	5	thunder_ring.jpg	Wield thunderous power in a quest to save the realm.	An action RPG where you journey through electrified worlds, mastering ancient rings that control the storms. With stunning visuals, deep lore, and skill-based combat, Thunder Ring is perfect for gamers seeking fantasy adventure and epic boss battles.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
10	Call of deny	video	16+	1	3	call_of_deny.jpg	Enter dark warzones where survival means denying all weakness.	A gritty, intense first-person shooter where you battle through morally complex conflicts in a dystopian future. With realistic graphics, a gripping campaign, and multiplayer options, Call of Deny challenges reflexes, tactics, and ethics alike. Mature content—recommended for older teens and adults.	2025-07-18 10:21:35.891	2025-07-18 10:23:35.986
6	GOLA spaceship	build	8+	1+	3	gola_spaceship.jpg	Construct an intergalactic spaceship and explore the cosmos freely.	This build-and-play set lets kids construct a futuristic GOLA-class spaceship with movable parts and glowing features. Perfect for sci-fi fans and aspiring engineers, it promotes creativity and problem-solving while inspiring dreams of space exploration.	2025-07-18 10:21:35.891	2025-07-18 10:23:42.351
15	GOLA Taj Mahal	build	8+	1+	1	gola_taj_mahal.jpg	Recreate India’s crown jewel with architectural precision and care.	This GOLA building kit allows children and adults to construct a detailed model of the Taj Mahal. With step-by-step instructions and quality bricks, it’s both a creative challenge and a cultural learning experience. Great for display and long sessions.	2025-07-18 10:21:35.891	2025-07-18 10:23:48.445
4	Sphynxs riddles	puzzle	6+	4	2	sphynxs_riddles.jpg	Solve ancient riddles to escape the Sphinx’s cunning traps.	Unravel cryptic puzzles left by the Sphinx in this engaging group game. Designed to challenge memory, logic, and teamwork, players must decode clues to win. A fantastic learning game that brings mythology to life for kids and families.	2025-07-18 10:21:35.891	2025-07-23 13:01:32.851
20	Secret agent Mike	figurine	3+	1	2	secret_agent_mike.jpg	Top-secret missions await with brave, sneaky Secret Agent Mike.	Dressed in full spy gear and armed with cool gadgets, Secret Agent Mike is always ready for covert operations. Perfect for imaginative solo play, Mike inspires adventure and storytelling in young secret agents. Durable and safe for kids aged 3 and up.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
21	Humanoid robot	video	12+	1	1	humanoid_robot.jpg	Control a futuristic android in a morally complex digital world.	Step into the shoes of a self-aware robot navigating humanity and ethics. This story-driven game explores AI consciousness, rebellion, and freedom with cinematic storytelling, puzzle-solving, and exploration. Ideal for fans of sci-fi narratives and choice-based gameplay.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
22	Chess	board	8+	2	5	chess.jpg	Outthink, outplay, and master the timeless game of strategy.	The ultimate board game of kings and queens, Chess hones logic, concentration, and strategic thinking. This beautifully made set is perfect for casual players or competitive minds, suitable for homes, schools, or clubs. A classic for all generations.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
24	Skateboard	video	6+	1	2	skateboard.jpg	Pull off tricks, stunts, and combos in skateboard paradise.	An energetic skateboarding game filled with parks, ramps, and challenges. Players customize boards, master flips, and compete in urban arenas. Great for younger gamers, it balances fun and skill-building in a vibrant, fast-paced virtual skate scene.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
25	God of win	video	18+	1	3	god_of_win.jpg	Wage divine war in this brutal mythological action saga.	Step into the sandals of a fallen god reclaiming power through epic combat and ancient magic. With cinematic visuals, intense battles, and mature themes, this game offers a visceral experience for adults. Not for the faint-hearted, but perfect for action fans.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
26	Purple tigress	figurine	3+	1	1	purple_tigress.jpg	Fierce, graceful, and ready to pounce—Purple Tigress awaits.	A striking jungle guardian, Purple Tigress features bold colors, flexible limbs, and fierce style. Great for animal-themed play or heroic stories, she brings power and elegance to any figurine collection. Designed for young imaginations and safe for little hands.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
27	Volley ball ball	sport	any	1+	3	volleyball_ball.jpg	Serve, set, and spike with this high-performance volleyball ball.	Perfect for indoor and beach play, this volleyball features a soft grip and durable surface. Great for players of all levels, it supports active fun, teamwork, and skill development in casual or competitive settings.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
28	Broken heart	board	6+	4-8	2	broken_heart.jpg	Mend friendships and solve emotional puzzles in this game.	In Broken Heart, players work together to repair shattered pieces of a symbolic heart by answering questions and sharing emotions. Aimed at young players and families, it encourages empathy, communication, and cooperative problem-solving in a playful, colorful format.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
29	Goblin army	card	6+	2	5	goblin_army.jpg	Build your goblin army and outsmart your sneaky opponents.	A fast-paced card game where players summon goblins, sabotage rivals, and try to control the battlefield. With silly art, unexpected twists, and quick rules, Goblin Army is perfect for kids and families who enjoy chaotic fun and mischievous creatures.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
30	Buildmag building	build	8+	1+	3	buildmag_building.jpg	Create detailed cityscapes using magnetic pieces and imagination.	The Buildmag Building set uses colorful magnetic tiles to let kids design and build realistic structures. Encouraging creativity, spatial reasoning, and engineering skills, it’s ideal for solo play or collaborative projects. Safe, durable, and endlessly replayable.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
31	Vaambbies	board	12+	2-6	4	vaambbies.jpg	Survive the night against vampire-zombie hybrids—Vaambbies are coming!	A thrilling horror-themed board game where players fight mutated vampire-zombie creatures across abandoned towns. Strategize, collect weapons, and survive waves of Vaambbies alone or with others. Featuring atmospheric art and tense gameplay, it’s a must-play for fans of cooperative survival games.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
32	Property	card	10+	4-6	5	property.jpg	Buy, trade, build—dominate the board through card play.	In this strategic property-themed card game, players collect sets, build houses, and bankrupt opponents through smart deals and surprise moves. Easy to learn but full of clever tactics, Property is great for families, parties, and anyone who loves competitive fun.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
33	Gooollllliin	card	6+	2-4	2	gooollllliin.jpg	Play wild goblin teams and score the funniest goals ever.	A goofy, goblin-themed soccer card game where you assemble bizarre teams, play tricks, and try to score goals. Packed with hilarious illustrations and unpredictable plays, Gooollllliin is fast, funny, and great for lighthearted battles with kids or friends.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
34	Jack and Saraa	video	12+	1-2	2	jack_and_saraa.jpg	Unravel mysteries as Jack and Saraa in twin adventures.	Play as two teen sleuths uncovering conspiracies, hidden relics, and ancient secrets. With co-op and solo modes, this mystery-action game blends puzzles, story, and exploration in vibrant environments. Ideal for fans of narrative adventures and buddy-team games.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
35	Rugby ball	sport	any	1+	4	rugby_ball.jpg	Tough and ready—perfect for backyard scrums and matches.	This rugged, high-quality rugby ball is built for play on all surfaces. Great for casual games, training, or school sports, it features a firm grip and durable material to withstand heavy use. Ideal for players of all levels and ages.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
36	Roddo	board	6+	2-4	3	roddo.jpg	Race through twisting roads in this colorful tile adventure.	Roddo is a family board game where players lay road tiles, connect routes, and race vehicles to destinations. With simple rules and vibrant pieces, it offers endless replayability and encourages spatial planning and friendly competition among kids and adults.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
37	Christmas puzzle	puzzle	any	1+	4	christmas_puzzle.jpg	Festive fun with snowy scenes and holiday cheer in pieces.	This delightful Christmas-themed puzzle features cozy villages, twinkling lights, and Santa surprises. Perfect for relaxing with family during the holidays, it promotes patience, visual focus, and holiday spirit. Suitable for puzzlers of all ages and skill levels.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
38	Blue wizard deck	card	6+	1	4	blue_wizard_deck.jpg	Summon arcane forces with powerful spells and mystical cards.	A solo magical card game where players cast spells and battle mystical foes using a Blue Wizard-themed deck. Each game offers new challenges, encouraging strategic thinking and magical storytelling. Great for kids and beginner card players who love fantasy.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
39	Ice panther	card	6+	2-6	4	ice_panther.jpg	Freeze your enemies with stealth, speed, and icy fury.	In this thrilling animal-based card game, players unleash the stealthy Ice Panther to freeze rivals, steal points, and survive jungle battles. With dynamic effects and beautiful art, it's ideal for quick, competitive play among kids and families.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
40	GOLA Eiffel Tower	build	8+	1+	5	gola_eiffel_tower.jpg	Construct the iconic Eiffel Tower with detailed building precision.	This GOLA set lets builders recreate the Eiffel Tower using durable bricks and clear instructions. Perfect for fans of architecture and Paris, it provides hours of creative building and a beautiful final display. Great for both play and decor.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
41	Onbau	card	6+	2-4	3	onbau.jpg	Summon strange creatures and battle for the mythical Onbau crystal.	A fast-paced fantasy card game where players summon beasts, cast spells, and compete for power. Easy to learn but rich in combos, Onbau blends strategy and unpredictability with fun illustrations. Designed for engaging play between friends and siblings.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
42	Blue lion	figurine	3+	1	2	blue_lion.jpg	Roar into action with the brave and bold BlueLion.	This sturdy and colorful lion figurine is perfect for imaginative jungle adventures. With posable limbs and a noble expression, BlueLion inspires storytelling and exploration. Safe and durable for kids 3 and up, it fits great with animal or hero playsets.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
43	Who's the murderer?	puzzle	any	2-6	3	whos_the_murderer.jpg	Solve clues, question suspects—can you find the killer?	This murder mystery puzzle game challenges players to piece together scenes, follow trails, and uncover the murderer. With cooperative and competitive modes, it’s ideal for family nights or parties. Encourages deduction, attention to detail, and team thinking.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
44	Buildmag house	build	8+	1+	2	buildmag_house.jpg	Design and build your dream house with magnetic bricks.	This Buildmag set lets kids create detailed houses using magnetic panels and accessories. A great intro to architecture, it blends creativity and engineering in a fun, hands-on way. Safe and sturdy for long-lasting play. Ideal for solo or group projects.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
45	Black tempest	video	12+	1	3	black_tempest.jpg	Face the storm in this dark, elemental action epic.	A high-action video game where players harness shadow and storm powers to defeat ancient forces. With fast combat, moody visuals, and deep lore, Black Tempest is perfect for players who love elemental magic and dark fantasy themes.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
46	Croquet ball	sport	any	1+	3	croquet_ball.jpg	Strike and score with a classic croquet tournament-grade ball.	This durable croquet ball is ideal for lawn matches and garden games. Designed for smooth roll and balance, it works perfectly with standard mallets. Great for outdoor fun, improving precision and coordination for players of all ages.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
47	Buildmag temple	build	8+	1+	3	buildmag_temple.jpg	Recreate ancient temples with magnetic pieces and historic details.	This Buildmag set allows players to build imaginative temples inspired by global architecture. Perfect for encouraging cultural curiosity and construction skills, it features themed magnetic parts and decorative tiles. A fun way to blend play with learning.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
48	CD hero biteman	figurine	3+	1	4	cd_hero_biteman.jpg	Save the day with fangs, armor, and techno gear.	CD Hero Biteman is a heroic figurine with vampire style, futuristic armor, and articulated limbs. Ideal for epic battle play and monster adventures, he sparks creativity and fits into any action figure lineup. Durable and safe for young fans.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
49	Mekkanik panzer	build	8+	1+	4	mekkanik_panzer.jpg	Assemble a mighty panzer with gears, armor, and movement.	This Mekkanik building kit includes everything needed to construct a detailed, functional tank model. With moving parts and realistic design, it encourages mechanical thinking and patience. Great for older kids and collectors who love military-style builds.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
50	Kaker	board	12+	2-8	5	kaker.jpg	Outplay your rivals in this twisted game of deception.	Kaker is a dark-humor strategy game where players bluff, betray, and manipulate their way to power. With shifting alliances, secret roles, and wild surprises, it’s perfect for groups seeking intense, unpredictable board game nights.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
51	Super fighter	figurine	3+	1	2	super_fighter.jpg	Gear up and strike with unstoppable Super Fighter power.	Super Fighter is a dynamic action figure ready for heroic play. Featuring posable limbs and cool accessories, it encourages imaginative battles and stories. Made for durability and excitement, it’s ideal for kids aged 3 and older.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
52	Red wizard	figurine	3+	1	1	red_wizard.jpg	Conjure fireballs and magic with powerful Red Wizard play.	This detailed wizard figurine comes with a spell staff, flowing robes, and bold colors. Great for magical-themed adventures or fantasy collections, it inspires roleplay and creative storytelling. Safe and designed for little hands.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
53	Snake venom	card	6+	2	2	snake_venom.jpg	Poison your opponent with strategy, speed, and deadly bites.	In Snake Venom, players race to collect venom cards and use cunning to trap and defeat their opponent. Quick, competitive, and full of sneaky twists, it’s great for two-player battles with a venomous edge.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
54	Celebrity Renee	figurine	3+	1	5	celebrity_renee.jpg	Pose, perform, and dazzle with superstar Celebrity Renee figure.	Renee is a glamorous figurine ready for the spotlight. With changeable outfits, accessories, and a microphone, she’s perfect for fashion shows and concert scenes. Encourages storytelling and creativity. A must-have for any young performer’s collection.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
55	Buildmag villa	build	8+	1+	4	buildmag_villa.jpg	Create your own luxury villa with modern magnetic designs.	This elegant building set from Buildmag features stylish pieces to construct a dream villa. Kids can design interiors, balconies, and more using strong, colorful magnets. Encourages planning, creativity, and fine motor skills. Great for solo builds or collaborative projects.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
56	Coloring picture	puzzle	any	1	2	coloring_picture.jpg	Bring the picture to life with your favorite colors.	A relaxing puzzle activity where children color pre-drawn scenes using their own imagination. Ideal for quiet, creative play that promotes fine motor skills and color recognition. Great for individual focus or parent-child interaction, suitable for all ages and skill levels.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
57	Mekkanik motorcycle	build	8+	1+	2	mekkanik_motorcycle.jpg	Build a high-speed bike with gears, bolts, and style.	This Mekkanik set challenges young engineers to construct a sleek motorcycle using mechanical parts and tools. Great for motor lovers and STEM fans, it teaches construction and creativity while resulting in a sturdy, functional model for display or imaginative play.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
58	Baseball ball	sport	any	1+	2	baseball_ball.jpg	Hit it out of the park with this official ball.	A standard-size, high-quality baseball ideal for games, practice, or casual backyard fun. Its durable stitching and grip make it perfect for throwing and batting. Great for players of all levels who enjoy the classic American sport.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
59	EWW wrestler Kean	figurine	3+	1	3	eww_wrestler_kean.jpg	Step into the ring with champion EWW fighter Kean.	Kean is a tough and poseable wrestling figure ready for action. With signature moves and ring-ready gear, he brings big energy to every match. Perfect for fans of wrestling and pretend play. Durable and safe for little hands.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
60	Mekkanik truck	build	8+	1+	5	mekkanik_truck.jpg	Build a rugged truck with moving wheels and parts.	This advanced Mekkanik set lets builders create a realistic truck complete with functional components. Perfect for kids who enjoy technical challenges and mechanical construction. Ideal for developing spatial thinking, patience, and problem-solving skills.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
61	Handball ball	sport	any	1+	1	handball_ball.jpg	Catch, pass, and score with this classic handball ball.	This lightweight, grippy handball is perfect for fast-paced indoor or outdoor matches. Sized for easy handling by both kids and adults, it's great for learning teamwork and coordination. Durable design for repeated use in play or training.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
62	Little big adventure	video	any	1	3	little_big_adventure.jpg	A magical journey awaits in this charming adventure game.	Explore fantastic worlds, solve quirky puzzles, and meet unforgettable characters in this whimsical video game adventure. Designed for all ages, it mixes humor and story with classic platformer mechanics. A great way to escape into imaginative fun.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
63	Bubble hater	puzzle	any	1	3	bubble_hater.jpg	Pop, dodge, and escape in this high-stakes bubble puzzle.	This fast-paced solo puzzle game challenges players to eliminate bubbles strategically while avoiding traps and time limits. Fun, quirky, and addictive, it sharpens reflexes and problem-solving with each level. Great for both kids and adults.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
64	Goalkeeper gloves	sport	any	1	2	goalkeeper_gloves.jpg	Protect the net with these strong and comfortable gloves.	Designed for young goalkeepers, these gloves offer grip, cushioning, and wrist support for blocking shots and catching balls. Lightweight and breathable, they’re great for practice or matches. Encourages physical activity and team sports skills.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
65	Golf ball	sport	any	1+	3	golf_ball.jpg	Precision-crafted for power, control, and smooth fairway flights.	A professional-grade golf ball with excellent balance and flight performance. Ideal for improving your game on the green or practicing your swing. Durable and designed for consistent roll and feel. Great for casual and serious players alike.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
66	Rubik's cube 4x4	puzzle	3+	1	2	rubiks_cube_4x4.jpg	Four layers, endless challenges—twist, turn, and solve it.	An advanced version of the classic puzzle, the 4x4 Rubik’s Cube offers more complexity and excitement. It encourages logic, patience, and pattern recognition. Great for older kids, teens, and anyone ready for a brain-twisting challenge.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
67	Tetanis	puzzle	3+	1	3	tetanis.jpg	Stack the blocks before time runs out—classic chaos.	A thrilling puzzle game inspired by falling-block challenges. Players must arrange shapes to fit perfectly before the stack reaches the top. Fun, fast, and mentally stimulating, Tetanis improves spatial awareness and reaction time. Perfect for solo play on the go.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
68	GOLA pirate ship	build	8+	1+	1	gola_pirate_ship.jpg	Set sail with your own custom-built pirate ship adventure.	Build a legendary pirate ship with detailed sails, cannons, and decks. This GOLA set promotes imaginative building and storytelling. Perfect for young builders and fans of swashbuckling tales. Includes easy instructions and sturdy bricks for hours of creative fun.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
69	Football masters	video	12+	1-6	5	football_masters.jpg	Master the pitch in the ultimate multiplayer football showdown.	This fast-paced football video game offers exciting solo and multiplayer matches, realistic animations, and customizable teams. Designed for sports fans who love strategy and action. Great for parties, online play, or training against AI opponents.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
70	Monkepo dragon	figurine	3+	1	1	monkepo_dragon.jpg	Fly high and breathe fire with Monkepo the brave.	A fierce but friendly dragon figurine with movable wings and textured scales. Perfect for fantasy roleplay or as part of a dragon collection. Durable and colorful, Monkepo inspires flights of imagination in kids aged 3 and up.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
71	Sudoku	puzzle	6+	1	5	sudoku.jpg	Train your brain with classic number logic challenges daily.	This version of Sudoku offers hundreds of puzzles for all skill levels. Ideal for improving concentration, logic, and problem-solving, it’s perfect for quiet playtime, travel, or mental exercise. Includes beginner to expert grids to keep players challenged and engaged.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
72	Valentine's puzzle	puzzle	any	1	4	valentines_puzzle.jpg	Piece together love in this heartwarming holiday puzzle.	Celebrate Valentine’s Day with this charming, romantic-themed puzzle. Featuring colorful, themed artwork and just the right level of challenge, it’s a sweet solo or shared activity for all ages. Ideal for seasonal play, relaxation, or gift giving.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
73	Mekkanik supercar	build	8+	1+	2	mekkanik_supercar.jpg	Assemble a sleek supercar with gears, detail, and speed.	This high-performance building set lets young engineers create a realistic, working supercar. Featuring moving parts and smooth design, it promotes creativity, fine motor skills, and technical learning. A perfect gift for future mechanics and car enthusiasts.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
74	Tokens chaos	board	10+	2	2	tokens_chaos.jpg	Collect tokens, create combos, and outsmart your opponent’s strategy.	Tokenschaos is a strategic two-player board game where you draft colorful tokens to build powerful combos. Easy to learn but rich in tactics, it rewards planning and adaptability. Fast-paced rounds make it ideal for game nights and thoughtful competition.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
75	Dark galaxy	video	12+	1	2	dark_galaxy.jpg	Explore cosmic mysteries in this epic, star-spanning adventure.	Dark galaxy throws players into deep space exploration with intense action and cosmic puzzles. You pilot your ship through alien sectors, battle foes, and uncover universal secrets. With rich visuals and immersive audio, it’s perfect for sci-fi fans seeking interstellar thrill.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
76	Donutgirl	figurine	3+	1	1	donut_girl.jpg	Sweet, fun-filled adventures await with Donut Girl figure.	Donutgirl is a whimsical figurine complete with bright outfit and doughnut-themed accessories. Perfect for imaginative play, she unfolds delightful adventures in a magical bakery world. Safe and sturdy for toddlers and young kids to enjoy culinary imagination and storytelling.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
77	Basketball ball	sport	any	1+	4	basketball_ball.jpg	Dribble, shoot, dunk—perfect for every court basketball game.	A high-quality basketball with excellent grip and bounce, suitable for indoor or outdoor courts. Sized for all ages, it encourages sporty play, coordination, and teamwork. Durable construction stands up to rigorous street games, training sessions, or casual pickup matches.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
78	Rubik's cube 3x3	puzzle	3+	1	5	rubiks_cube_3x3.jpg	Classic cube challenge—twist, turn, and solve thousands of patterns.	The iconic 3×3 Rubik’s Cube offers endless puzzle fun, improving memory, spatial reasoning, and problem-solving. Portable and engaging, it’s perfect for children and adults alike. Numerous tutorials and speed-cubing communities support players at any skill level.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
79	Frog swamp	board	6+	2-8	4	frog_swamp.jpg	Leap through lily pads to capture the most frogs.	In Frog Swamp, players move frog tokens across swamp boards, hopping strategically to collect points. Features cute art, variable maps, and easy rules. Family-friendly and engaging, it promotes planning and friendly rivalry in a lighthearted, amphibian-filled adventure.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
80	Boules balls	sport	any	1+	2	boules_balls.jpg	Roll heavy steel balls close to target—classic boules fun.	Complete set of boules (petanque) balls with jack and measuring tool. Great for outdoor gatherings, parks, or backyard play. Encourages precision, team play, and social interaction. Durable, tournament-quality metal for authentic boules experience.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
81	Alone	card	3+	1	4	alone.jpg	Face the challenge solo in this intriguing card game.	Alone is a solo card game where you draw, decide, and strive to beat the deck. Featuring simple mechanics and strategic choices, it provides satisfying short sessions that challenge your wits. Ideal for quiet playtime or travel.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
82	Guss gume	puzzle	any	4	3	guss_gume.jpg	Collect gummies, match patterns, and satisfy sweet puzzle cravings.	Gussgume is a colorful tile-matching puzzle that challenges players to group gummy shapes by color and pattern. Designed for quick plays or longer sessions, it boosts pattern recognition and strategic thinking. Lighthearted and perfect for all ages.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
83	First fantasy	video	12+	1	5	first_fantasy.jpg	Embark on first fantasy quest filled with magic and bravery.	First Fantasy is a beautifully crafted RPG where you explore magical kingdoms, battle mythical creatures, and forge your hero’s destiny. Rich storylines, tactical combat, and customizable characters immerse players in a memorable journey through an enchanting world.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
84	Ohgiyu demon	figurine	3+	1	2	ohgiyu_demon.jpg	Unleash dark powers with the fearsome Ohgiyu Demon.	Ohgiyu Demon is a dramatic and detailed figurine featuring horns, wings, and intricate armor. Perfect for fantasy-themed play or collectors, it brings a sense of mystique and power. Durable and designed for imaginative storytelling.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
85	Shark fire	card	6+	3	4	shark_fire.jpg	Devour opponents with blazing shark attacks and fiery combos.	Shark fire is a fast-paced card game where you summon fiery sharks and unleash combo attacks on opponents. Colorful art and dynamic gameplay make it exciting for kids and families. Easy to learn, hard to master.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
86	Dragon's treasure	board	10+	2-8	3	dragons_treasure.jpg	Seek gold and outwit dragons in daring treasure hunts.	In Dragon’s Treasure, players explore caverns, collect loot, and dodge dragon attacks. Features dice-driven turns, loot cards, and player interaction. Perfect for group sessions with moderate strategy and thrilling moments of risk and reward.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
87	Cricket ball	sport	any	1+	3	cricket_ball.jpg	Swing hard, bowl fast—the heart of cricket matches.	A well-crafted leather cricket ball offering traditional feel and performance. Designed for training, matches, and casual play. Durable stitching and firm core provide reliable bounce and seam movement. Essential for any cricket enthusiast.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
88	Alllllens	board	12+	2-8	4	alllllens.jpg	Survive alien invasion—aliens among us in this social deduction.	Alllllens is a hidden-role board game where players identify alien impostors while completing missions. Tense, atmospheric, and full of bluffing, it encourages deduction, teamwork, and strategy. Perfect for game nights with a fun sci-fi twist.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
89	Iron fist	video	12+	1-2	3	iron_fist.jpg	Fight through streets and foes with powerful hand-to-hand combat.	Iron Fist is a brawler game featuring co-op and solo modes. Players master combos, unlock special moves, and face tough enemies across gritty environments. Perfect for action fans and martial arts enthusiasts.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
90	Joker	card	3+	4-8	4	joker.jpg	Add chaos to any card game with the playful Joker.	A set of colorful Joker-themed cards with wild effects that spice up traditional games. Use them in UNO-style matches or as standalone chaos creators. Great for families and parties seeking unexpected twists.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
91	Action soldier	figurine	3+	1	3	action_soldier.jpg	Gear up for combat missions with daring Action Soldier.	Action Soldier is a highly poseable figurine equipped with tactical gear and accessories. Perfect for imaginative military play, scenarios, or collector displays. Durable, detailed, and ready for battle.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
92	The G	card	6+	4-10	5	the_g.jpg	Lead the coolest group with the legendary “G” cards.	The G is a social card game where players build and manage a crew using “G” cards that grant bonuses. It combines strategy and humor, great for larger groups, parties, and casual competitive play.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
93	Hockey ball	sport	any	1+	1	hockey_ball.jpg	Glide, pass, score—perfect for street and indoor hockey.	A lightweight, hard-plastic street hockey ball ideal for roller or street hockey games. Durable and easy to see, it encourages active play and teamwork. Great for parks, drives, and backyards.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
94	Octopus shadow	card	6+	3	3	octopus_shadow.jpg	Cast shadowy tentacles to outwit opponents in card duels.	Octopus Shadow is a strategic three-player card game with deep tentacle-themed powers. Players use stealthy moves and blocking strategies to dominate the table. With dark ocean art and clever mechanics, it offers a unique twist on card play.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
95	Lead the way	board	6+	4-6	1	lead_the_way.jpg	Guide explorers through jungle paths to reach ancient relics.	Lead the Way is a cooperative adventure game where players navigate jungle tiles to recover artifacts. Easy rules and teamwork-focused gameplay make it ideal for families. Offers puzzle-solving and strategic planning in a lighthearted exploration setting.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
96	Goose panick	board	3+	2-6	5	goose_panick.jpg	Honk, chase, and chaos—geese run wild in this frantic game.	Goose Panick is a fast-paced, family-friendly game where players race across boards while geese cause mayhem. With simple dribble rules and chaotic geese tokens, it’s laugh-out-loud fun for kids and adults alike.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
97	Conquest	board	10+	4-8	1	conquest.jpg	Expansion, alliances, betrayal—conquer lands and dominate rivals.	Conquest is a deep strategy board game emphasizing territory control, diplomacy, and resource management. Players form and break alliances to win. With high replayability and intricate choices, it’s perfect for experienced gamers craving epic conflicts.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
98	GOLA Colosseum	build	8+	1+	3	gola_colosseum.jpg	Construct ancient Colosseum and relive historic gladiator battles.	This GOLA building set guides builders in creating a detailed Colosseum model. Featuring arches, tiers, and historical accuracy, it doubles as educational décor and interactive toy. Ideal for history enthusiasts and hands-on builders.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
99	Holy priest deck	card	6+	1	1	holy_priest_deck.jpg	Heal, bless, and support in holy priest solo card game.	Holy Priest Deck is a solo card game themed around healing and protection. Players draw blessings, cure afflictions, and strive for spiritual balance. Easy to learn with peaceful themes, it’s a calming and thoughtful gaming experience.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
100	Buildmag bridge	build	8+	1+	5	buildmag_bridge.jpg	Engineer your own magnetic bridge across imaginary landscapes.	This Buildmag kit challenges builders to design sturdy bridges using magnetic tiles and supports. Promotes creativity, physics thinking, and fine motor skills. Ideal for solo or team projects, it inspires budding engineers and planners.	2025-07-18 10:21:35.891	2025-07-18 10:21:35.891
8	Xweird draughts	board	10+	2	0	xweird_draughts.jpg	Classic checkers twisted with strange rules and warped strategies.	This mind-bending twist on traditional checkers introduces unpredictable movements, special tiles, and new win conditions. Designed for seasoned board gamers and strategic thinkers, Xweird Draughts will challenge your expectations and test your adaptability in every match.	2025-07-18 10:21:35.891	2025-07-18 10:23:19.083
23	Buildmag skyscraper	build	8+	1+	0	buildmag_skyscraper.jpg	Design and construct towering skyscrapers with magnetic precision pieces.	This hands-on building set challenges players to create vertical marvels using magnetic blocks and structural accessories. Encourages creativity, STEM learning, and patience. Ideal for solo or collaborative projects, the Buildmag Skyscraper kit turns playtime into an architectural journey.	2025-07-18 10:21:35.891	2025-07-18 10:24:00.719
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, "firstName", "lastName", "birthDate", country, "postalCode", street, number, phone, email, password, role, "createdAt", "lastModified") FROM stdin;
1	Kevin	Maouchi	2025-07-26 00:00:00	France	76650	Frederic Chopin	8	+33649174805	maouchi76@hotmail.fr	$2b$10$jtowmpac.8gFqoCvBtSm/.rpYBRxBvsML2Iv4nuXbNBvj5jbkl5Uy	member	2025-07-18 10:22:48.802	2025-07-18 10:22:48.802
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
79a63b14-f621-45eb-98db-f63110589730	bf54bfce2eb302c6abc7631c61bf3dd68e6f47ecc7996d105563d52de47af5c3	2025-07-18 10:20:24.910382+00	20250718102024_init	\N	\N	2025-07-18 10:20:24.903044+00	1
\.


--
-- Name: Borrow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Borrow_id_seq"', 6, true);


--
-- Name: Game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Game_id_seq"', 100, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, true);


--
-- Name: Borrow Borrow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "Borrow_pkey" PRIMARY KEY (id);


--
-- Name: Game Game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Game"
    ADD CONSTRAINT "Game_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Borrow Borrow_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "Borrow_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public."Game"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Borrow Borrow_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "Borrow_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--



