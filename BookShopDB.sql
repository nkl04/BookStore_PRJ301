USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BookstoreDB')
BEGIN
	ALTER DATABASE BookstoreDB SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE BookstoreDB SET ONLINE;
	DROP DATABASE BookstoreDB;
END

GO

CREATE DATABASE BookstoreDB
GO

USE BookstoreDB
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO 

---------------------- Create tables ------------------
create table Account(
	userID int IDENTITY(1,1) PRIMARY KEY,
	firstName nvarchar(30) not null,
	lastname nvarchar(30) not null,
	email nvarchar(40) not null,
	password nvarchar(50) not null,
	image nvarchar(100) default 'user (1).png',
	address nvarchar(100) not null,
	isAdmin bit not null
)

create table Publisher(
	ID int IDENTITY(1,1) PRIMARY KEY,
	name nvarchar(200) not null,
)

create table Author(
	ID int IDENTITY(1,1) PRIMARY KEY,
	name nvarchar(200) not null,
)
create table Genre(
	ID int IDENTITY(1,1) PRIMARY KEY,
	title nvarchar(200) not null,
)
create table Book(
	ID int IDENTITY(1,1) PRIMARY KEY,
	title nvarchar(80) not null,
	description nvarchar(2000) not null,
	language nvarchar(20) not null,
	publication_date date not null,
	bookImage nvarchar(100) not null,
	qtyInStock int not null,
	price float not null,
	pages int not null,
	publisherID int foreign key references Publisher(ID),
)
create table BookGenre(
	bookID int foreign key references Book(ID),
	genreID int foreign key references Genre(ID),
)
create table BookAuthor(
	bookID int foreign key references Book(ID),
	authorID int foreign key references Author(ID),
)
create table ShopOrder(
	ID int IDENTITY(1,1) PRIMARY KEY,	
	orderDate date not null,
	orderStatus nvarchar(10),
	userID int foreign key references Account(userID),
)
create table OrderLine(
	bookID int foreign key references Book(ID),
	orderID int foreign key references ShopOrder(ID),
	quantity int not null,
	price float not null,
)

create table Cart(
	userID int foreign key references Account(userID),
	bookID int foreign key references Book(ID),
	quantity int not null,
)

create table Wishlist(
	userID int foreign key references Account(userID),
	bookID int foreign key references Book(ID),
)

-----------------Insert data-------------------
insert into Account(firstName, lastname, email, password, address, isAdmin) values
('duc', 'nguyen', 'duc123@gmail.com', '123', 'Ha Noi', 1),
(N'Đức', N'Nguyễn', 'manhduc112004@gmail.com', '123', 'Ha Noi', 0);

----------------------------Insert author------------------------
INSERT INTO Author
VALUES
('Sarah J. Maas'),
('Emily Henry'),
('Ali Hazelwood'),
('Kate Axelrod'),
('Emily Henry'),
('Hannah Grace'),
('T. Kingfisher'),
('Mark Z. Danielewski'),
('Tlotlo Tsamaase'),
('Stephen King'),
('Bora Chung'),
('Cole Arthur Riley'),
('Jamie Kern Lima'),
('Marsha Gray Hill'),
('A''Ja Wilson'),
('Ijeoma Oluo'),
('Bell Hooks'),
('Anne Varichon'),
('Kyne Santos '),
('Anthony Youn '),
('Peter del Tredici'),
('J. Kenji López-Alt'),
('Sabrina Imbler'),
('Richard Hamming'),
('Matthew Walker '),
('Lisa Feldman Barrett'),
('Tamsyn Muir'),
('Cixin Liu'),
('Stephen Markley'),
('James S. A. Corey'),
('Dave Eggers'),
('Bianca Bosker'),
('Stuart Semple'),
('Sarah Cray'),
('Thandiwe Muriu'),
('Erin Williams'),
('Kendra Norton');

--------------------------Insert publisher--------------------
insert into Publisher values
('Bloomsbury Publishing'),
('Berkley Books'),
('Clash Books'),
('Atria Books'),
('Nightfire Tor Publishing Group'),
('Pantheon Books'),
('Erewhon Books'),
('Scribner Book Company'),
('Algonquin Books'),
('Gallery Books'),
('Convergent Books'),
('Hay House'),
('Forefront Books'),
('Flatiron Books: A Moment of Lift Book'),
('HarperOne'),
('William Morrow & Company'),
('Princeton University Press'),
('Johns Hopkins University Press'),
('Hanover Square Press'),
('Comstock Publishing'),
('W. W. Norton & Company'),
('Little Brown and Company'),
('Stripe Press'),
('Mariner Books'),
('Algonquin Books'),
('Tordotcom'),
('Tor Books'),
('Simon & Schuster'),
('Orbit'),
('Vintage'),
('Viking'),
('Rockport Publishers'),
('Quarry Books'),
('Chronicle Chroma'),
('Abrams Comicarts'),
('Workman Publishing');



----------------------------------Insert Book-----------------------------------------------------------
INSERT INTO Book VALUES (N'House of Flame and Shadow',N'<p>The stunning third book in the sexy, action-packed Crescent City series, following the global bestsellers House of Earth and Blood and House of Sky and Breath.</p><p>Bryce Quinlan never expected to see a world other than Midgard, but now that she has, all she wants is to get back. Everything she loves is in Midgard: her family, her friends, her mate. Stranded in a strange new world, she''s going to need all her wits about her to get home again. And that''s no easy feat when she has no idea who to trust. Hunt Athalar has found himself in some deep holes in his life, but this one might be the deepest of all. After a few brief months with everything he ever wanted, he''s in the Asteri''s dungeons again, stripped of his freedom and without a clue as to Bryce''s fate. He''s desperate to help her, but until he can escape the Asteri''s leash, his hands are quite literally tied. In this sexy, breathtaking sequel to the #1 bestsellers House of Earth and Blood and House of Sky and Breath, Sarah J. Maas''s Crescent City series reaches new heights as Bryce and Hunt''s world is brought to the brink of collapse-with its future resting on their shoulders.</p>',N'English', '2024-1-30', N'House-of-Flame-and-Shadow.jpg',12,29.76,848,1),
	(N'A Court of Thorns and Roses',N'<p>The sexy, action-packed first book in the #1 New York Times bestselling Court of Thorns and Roses series from Sarah J. Maas.</p><p>When nineteen-year-old huntress Feyre kills a wolf in the woods, a terrifying creature arrives to demand retribution. Dragged to a treacherous magical land she knows about only from legends, Feyre discovers that her captor is not truly a beast, but one of the lethal, immortal faeries who once ruled her world. At least, he''s not a beast all the time. As she adapts to her new home, her feelings for the faerie, Tamlin, transform from icy hostility into a fiery passion that burns through every lie she''s been told about the beautiful, dangerous world of the Fae. But something is not right in the faerie lands. An ancient, wicked shadow is growing, and Feyre must find a way to stop it, or doom Tamlin-and his world-forever. From bestselling author Sarah J. Maas comes a seductive, breathtaking book that blends romance, adventure, and faerie lore into an unforgettable read.</p>',N'English','2020-06-02', N'A-Court-of-Thorns-and-Roses.jpg',20,17.67,448,1),
	(N'Kingdom of Ash',N'<p>Together they will rise. Or together they will fall.</p><p>The epic finale to the #1 bestselling Throne of Glass series by Sarah J. Maas. Aelin Galathynius has vowed to save her people-but at a tremendous cost. Locked in an iron coffin by the Queen of the Fae, Aelin must draw upon her fiery will as she endures months of torture. The knowledge that yielding to Maeve will doom those she loves keeps her from breaking, but her resolve unravels with each passing day. With Aelin captured, her friends and allies have scattered. Some bonds will grow even deeper, while others will be severed forever. But as destinies weave together at last, all must stand together if Erilea is to have any hope of salvation. Sarah J. Maas''s #1 New York Times bestselling Throne of Glass series draws to an explosive conclusion as Aelin fights for her life, her people, and the promise of a better world.</p>',N'English','2023-02-14',N'Kingdom-of-Ash.jpg',10.0,19.53,992,1),
	(N'Funny Story',N'<p>Daphne always loved the way her fianc&eacute; Peter told their story. How they met (on a blustery day), fell in love (over an errant hat), and moved back to his lakeside hometown to begin their life together. He really was good at telling it...right up until the moment he realized he was actually in love with his childhood best friend Petra.</p><p>Which is how Daphne begins her new story: Stranded in beautiful Waning Bay, Michigan, without friends or family but with a dream job as a children''s librarian (that barely pays the bills), and proposing to be roommates with the only person who could possibly understand her predicament: Petra''s ex, Miles Nowak.</p><p>Scruffy and chaotic--with a penchant for taking solace in the sounds of heart break love ballads --Miles is exactly the opposite of practical, buttoned up Daphne, whose coworkers know so little about her they have a running bet that she''s either FBI or in witness protection. The roommates mainly avoid one another, until one day, while drowning their sorrows, they form a tenuous friendship and a plan. If said plan also involves posting deliberately misleading photos of their summer adventures together, well, who could blame them?</p><p>But it''s all just for show, of course, because there''s no way Daphne would actually start her new chapter by falling in love with her ex-fianc&eacute;''s new fianc&eacute;e''s ex...right?</p>',N'English','2023-04-23',N'Funny-Story.jpg',8,26.97,400,2),
	(N'Bride',N'<p>A dangerous alliance between a Vampyre bride and an Alpha Werewolf becomes a love deep enough to sink your teeth into in this new paranormal romance from the #1 New York Times bestselling author of Love, Theoretically and The Love Hypothesis.</p><p>Misery Lark, the only daughter of the most powerful Vampyre councilman of the Southwest, is an outcast--again. Her days of living in anonymity among the Humans are over: she has been called upon to uphold a historic peacekeeping alliance between the Vampyres and their mortal enemies, the Weres, and she sees little choice but to surrender herself in the exchange--again...</p><p>Weres are ruthless and unpredictable, and their Alpha, Lowe Moreland, is no exception. He rules his pack with absolute authority, but not without justice. And, unlike the Vampyre Council, not without feeling. It''s clear from the way he tracks Misery''s every movement that he doesn''t trust her. If only he knew how right he was....</p><p>Because Misery has her own reasons to agree to this marriage of convenience, reasons that have nothing to do with politics or alliances, and everything to do with the only thing she''s ever cared about. And she is willing to do whatever it takes to get back what''s hers, even if it means a life alone in Were territory...alone with the wolf.</p>',N'English','2024-02-06',N'Bride.jpg',10,17.67,416,2),
	(N'How to Get Along Without Me',N'<p>How to Get Along Without Me is a collection that summons the perversity and poignance of twentysomething dating lives from a bracingly wry and honest new literary voice. In a world designed for couples, the protagonists of these interconnected stories have easy access to acquaintances with benefits but no paths to emotional intimacy.&quot;Surprising, funny, and painfully true. How to Get Along Without Me is an anthropological account of dating, a catalogue of shitheads, a love letter to grandparents, and a reminder that those years of flailing in love and failing to launch are ''taut with possibility.''&quot; --Christine Smallwood, author of The Life of the Mind &quot;Viciously funny and unashamedly sexy stories that plumb the loneliness of desire from first swipe to coupledom.&quot; --Danielle Lazarin, author of Back Talk&quot;The stories in How to Get Along Without Me are wary and beautiful, savage and true. Kate Axelrod has given us a book that is both modern and timeless.&quot; --Lindsay Hunter, author of Hot Springs Drive&quot;The perfect stories for reanimating your soul when you''ve gone numb online but still yearn to engage with the human condition.&quot; --Elisa Albert, Author of Human Blues<br>&quot;Axelrod''s prose is careful, intelligent, and contemplative...&quot; --Publishers Weekly</p>',N'English','2023-04-16',N'How-to-Get-Along-Without-Me.jpg',7,15.76,190,3),
	(N'Not in Love',N'<p>Rue Siebert might not have it all, but she has enough a few friends she can always count on, the financial stability she yearned for as a kid, and a successful career as a biotech engineer at Kline, one of the most promising start-ups in the field of food science. Her world is stable, pleasant, and hard-fought. Until a hostile takeover and its offensively attractive front man threatens to bring it all crumbling down.</p><p>Eli Killgore and his business partners want Kline, period. Eli has his own reasons for pushing this deal through--and he''s a man who gets what he wants. With one burning exception: Rue. The woman he can''t stop thinking about. The woman who''s off-limits to him.</p><p>Torn between loyalty and an undeniable attraction, Rue and Eli throw caution out the lab and the boardroom windows. Their affair is secret, no-strings-attached, and has a built-in deadline: the day one of their companies will prevail. But the heart is risky business--one that plays for keeps.</p>',N'English','2023-06-11',N'Not-in-Love.jpg',7,17.67,400,2),
	(N'Happy Place',N'<p>A couple who broke up months ago pretend to still be together for their annual weeklong vacation with their best friends in this glittering and wise new novel from #1 New York Times bestselling author Emily Henry.<br>Harriet and Wyn have been the perfect couple since they met in college--they go together like salt and pepper, honey and tea, lobster and rolls. Except, now--for reasons they''re still not discussing--they don''t.<br>They broke up five months ago. And still haven''t told their best friends.<br>Which is how they find themselves sharing a bedroom at the Maine cottage that has been their friend group''s yearly getaway for the last decade. Their annual respite from the world, where for one vibrant, blissful week they leave behind their daily lives; have copious amounts of cheese, wine, and seafood; and soak up the salty coastal air with the people who understand them most.<br>Only this year, Harriet and Wyn are lying through their teeth while trying not to notice how desperately they still want each other. Because the cottage is for sale and this is the last week they''ll all have together in this place. They can''t stand to break their friends'' hearts, and so they''ll play their parts. Harriet will be the driven surgical resident who never starts a fight, and Wyn will be the laid-back charmer who never lets the cracks show. It''s a flawless plan (if you look at it from a great distance and through a pair of sunscreen-smeared sunglasses). After years of being in love, how hard can it be to fake it for one week...in front of those who know you best?</p>',N'English','2023-04-25',N'Happy-Place.jpg',7,25.11,400,2),
	(N'Wildfire',N'<p>The latest in the TikTok sensation and deliciously &quot;swoonworthy&quot; (Elena Armas, New York Times bestselling author) Maple Hills series follows two summer camp counselors who reconnect after a sizzling one-night stand. Maple Hills students Russ Callaghan and Aurora Roberts cross paths at a party celebrating the end of the academic year, where a drinking game results in them having a passionate one-night stand. Never one to overstay her welcome (or expect much from a man), Aurora slips away before Russ even has the chance to ask for her full name. Imagine their surprise when they bump into each other on the first day of the summer camp where they are both counselors, hoping to escape their complicated home lives by spending the summer working. Russ hopes if he gets far enough away from Maple Hills, he can avoid dealing with the repercussions of his father''s gambling addiction, while Aurora is tired of craving attention from everyone around her, and wants to go back to the last place she truly felt at home. Russ knows breaking the camp''s strict &quot;no staff fraternizing&quot; rule will have him heading back to Maple Hills before the summer is over, but unfortunately for him, Aurora has never been very good at caring about the rules. Will the two learn to peacefully coexist? Or did their one night together start a fire they can''t put out?</p>',N'English','2023-10-03',N'Wildfire.jpg',7,17.66,400,4),
	(N'Love, Theoretically',N'<p>An Indie Next and Library Reads Pick!<br>Rival physicists collide in a vortex of academic feuds and fake dating shenanigans in this delightfully STEMinist romcom from the New York Times bestselling author of The Love Hypothesis and Love on the Brain.<br>The many lives of theoretical physicist Elsie Hannaway have finally caught up with her. By day, she''s an adjunct professor, toiling away at grading labs and teaching thermodynamics in the hopes of landing tenure. By other day, Elsie makes up for her non-existent paycheck by offering her services as a fake girlfriend, tapping into her expertly honed people-pleasing skills to embody whichever version of herself the client needs.<br>Honestly, it''s a pretty sweet gig--until her carefully constructed Elsie-verse comes crashing down. Because Jack Smith, the annoyingly attractive and arrogant older brother of her favorite client, turns out to be the cold-hearted experimental physicist who ruined her mentor''s career and undermined the reputation of theorists everywhere. And he''s the same Jack Smith who rules over the physics department at MIT, standing right between Elsie and her dream job.<br>Elsie is prepared for an all-out war of scholarly sabotage but...those long, penetrating looks? Not having to be anything other than her true self when she''s with him? Will falling into an experimentalist''s orbit finally tempt her to put her most guarded theories on love into practice?</p>',N'English','2023-06-13',N'Love-Theoretically.jpg',7,15.81,400,2),
	(N'What Feasts at Night',N'<p>After their terrifying ordeal at the Usher manor, Alex Easton feels as if they just survived another war. All they crave is rest, routine, and sunshine, but instead, as a favor to Angus and Miss Potter, they find themself heading to their family hunting lodge, deep in the cold, damp forests of their home country, Gallacia.<br>In theory, one can find relaxation in even the coldest and dampest of Gallacian autumns, but when Easton arrives, they find the caretaker dead, the lodge in disarray, and the grounds troubled by a strange, uncanny silence. The villagers whisper that a breath-stealing monster from folklore has taken up residence in Easton''s home. Easton knows better than to put too much stock in local superstitions, but they can tell that something is not quite right in their home. . . or in their dreams.</p>',N'English','2024-02-13',N'What-Feasts-at-Night.jpg',7,18.59,160,5),
	(N'House of Leaves',N'<p>Years ago, when House of Leaves was first being passed around, it was nothing more than a badly bundled heap of paper, parts of which would occasionally surface on the Internet. No one could have anticipated the small but devoted following this terrifying story would soon command. Starting with an odd assortment of marginalized youth--musicians, tattoo artists, programmers, strippers, environmentalists, and adrenaline junkies--the book eventually made its way into the hands of older generations, who not only found themselves in those strangely arranged pages but also discovered a way back into the lives of their estranged children.<br>Now made available in book form, complete with the original colored words, vertical footnotes, and second and third appendices, the story remains unchanged. Similarly, the cultural fascination with House of Leaves remains as fervent and as imaginative as ever. The novel has gone on to inspire doctorate-level courses and masters theses, cultural phenomena like the online urban legend of &quot;&quot;the backrooms,&quot;&quot; and incredible works of art in entirely unrealted mediums from music to video games.<br>Neither Pulitzer Prize-winning photojournalist Will Navidson nor his companion Karen Green was prepared to face the consequences of the impossibility of their new home, until the day their two little children wandered off and their voices eerily began to return another story--of creature darkness, of an ever-growing abyss behind a closet door, and of that unholy growl which soon enough would tear through their walls and consume all their dreams.</p>',N'English','2000-03-07',N'House-of-Leaves.jpg',7,26.97,736,6),
	(N'Womb City',N'<p>&quot;Masterful . . . Tsamaase has created a disturbing techno dystopia in a future Botswana that terrifies with its echoes of our own increasingly authoritarian cyber-policed world. This beautifully written work haunts and upends expectations with its resurrected ghosts and gods and ancestors of Motswana cosmology. What an accomplished debut!&quot; --T. L. Huchu, Caine Prize finalist and author of The Library of the Dead<br>This genre-bending Africanfuturist horror novel blends The Handmaid''s Tale with Get Out in an adrenaline-packed, cyberpunk body-hopping ghost story exploring motherhood, memory, and a woman''s right to her own body.<br>Nelah seems to have it all: fame, wealth, and a long-awaited daughter growing in a government lab. But, trapped in a loveless marriage to a policeman who uses a microchip to monitor her every move, Nelah''s perfect life is precarious. After a drug-fueled evening culminates in an eerie car accident, Nelah commits a desperate crime and buries the body, daring to hope that she can keep one last secret.<br>The truth claws its way into Nelah''s life from the grave.<br>As the ghost of her victim viciously hunts down the people Nelah holds dear, she is thrust into a race against the clock: in order to save any of her remaining loved ones, Nelah must unravel the political conspiracy her victim was on the verge of exposing--or risk losing everyone.<br>Set in a cruel futuristic surveillance state where bodies are a government-issued resource, this harrowing story is a twisty, nail-biting commentary on power, monstrosity, and bodily autonomy. In sickeningly evocative prose, Womb City interrogates how patriarchy pits women against each other as unwitting collaborators in their own oppression. In this devastatingly timely debut novel, acclaimed short fiction writer Tlotlo Tsamaase brings a searing intelligence and Botswana''s cultural sensibility to the question: just how far must a woman go to bring the whole system crashing down?</p>',N'English','2024-01-23',N'Womb-City.jpg',7,26.04,416,7),
	(N'What Moves the Dead',N'<p>A very special hardcover edition, featuring foil stamp on the casing and custom endpapers illustrated by the author.<br>When Alex Easton, a retired soldier, receives word that their childhood friend Madeline Usher is dying, they race to the ancestral home of the Ushers in the remote countryside of Ruritania.<br>What they find there is a nightmare of fungal growths and possessed wildlife, surrounding a dark, pulsing lake. Madeline sleepwalks and speaks in strange voices at night, and her brother Roderick is consumed with a mysterious malady of the nerves.<br>Aided by a redoubtable British mycologist and a baffled American doctor, Alex must unravel the secret of the House of Usher before it consumes them all.</p>',N'English','2022-07-12',N'What-Moves-the-Dead.jpg',7,18.59,176,5),
	(N'Holly',N'<p>Stephen King''s Holly marks the triumphant return of beloved King character Holly Gibney. Readers have witnessed Holly''s gradual transformation from a shy (but also brave and ethical) recluse in Mr. Mercedes to Bill Hodges''s partner in Finders Keepers to a full-fledged, smart, and occasionally tough private detective in The Outsider. In King''s new novel, Holly is on her own, and up against a pair of unimaginably depraved and brilliantly disguised adversaries.<br>When Penny Dahl calls the Finders Keepers detective agency hoping for help locating her missing daughter, Holly is reluctant to accept the case. Her partner, Pete, has Covid. Her (very complicated) mother has just died. And Holly is meant to be on leave. But something in Penny Dahl''s desperate voice makes it impossible for Holly to turn her down.<br>Mere blocks from where Bonnie Dahl disappeared live Professors Rodney and Emily Harris. They are the picture of bourgeois respectability: married octogenarians, devoted to each other, and semi-retired lifelong academics. But they are harboring an unholy secret in the basement of their well-kept, book-lined home, one that may be related to Bonnie''s disappearance. And it will prove nearly impossible to discover what they are up to: they are savvy, they are patient, and they are ruthless.<br>Holly must summon all her formidable talents to outthink and outmaneuver the shockingly twisted professors in this chilling new masterwork from Stephen King.<br>&quot;I could never let Holly Gibney go. She was supposed to be a walk-on character in Mr. Mercedes and she just kind of stole the book and stole my heart. Holly is all her.&quot; --</p>',N'English','2023-09-05',N'Holly.jpg',7,27.90,464,8),
	(N'Cursed Bunny: Stories',N'<p>From an author never before published in the United States, Cursed Bunny is unique and imaginative, blending horror, sci-fi, fairy tales, and speculative fiction into stories that defy categorization. By turns thought-provoking and stomach-turning, here monsters take the shapes of furry woodland creatures and danger lurks in unexpected corners of everyday apartment buildings. But in this unforgettable collection, translated by the acclaimed Anton Hur, Chung''s absurd, haunting universe could be our own.<br>&quot;The Head&quot; follows a woman haunted by her own bodily waste. &quot;The Embodiment&quot; takes us into a dystopian gynecology office where a pregnant woman is told that she must find a father for her baby or face horrific consequences. Another story follows a young monster, forced into underground fight rings without knowing his own power. The titular fable centers on a cursed lamp in the shape of a rabbit, fit for a child''s bedroom but for its sinister capabilities.<br>No two stories are alike, and readers will be torn whether to race through them or savor Chung''s wit and frenetic energy on every page. Cursed Bunny is a book that screams to be read late into the night and passed on to the nearest set of hands the very next day.<br>&quot;Like the work of Carmen Maria Machado and Aoko Matsuda, Chung''s stories are so wonderfully, blisteringly strange and powerful that it''s almost impossible to put Cursed Bunny down.&quot; &#8213;Kelly Link, bestselling author of Get In Trouble</p>',N'English','2022-12-06',N'Cursed-Bunny.jpg',7,16.73,256,9),
	(N'You Like It Darker: Stories',N'<p>&quot;You like it darker? Fine, so do I,&quot; writes Stephen King in the afterword to this magnificent new collection of twelve stories that delve into the darker part of life--both metaphorical and literal. King has, for half a century, been a master of the form, and these stories, about fate, mortality, luck, and the folds in reality where anything can happen, are as rich and riveting as his novels, both weighty in theme and a huge pleasure to read. King writes to feel &quot;the exhilaration of leaving ordinary day-to-day life behind,&quot; and in You Like It Darker, readers will feel that exhilaration too, again and again.<br>&quot;Two Talented Bastids&quot; explores the long-hidden secret of how the eponymous gentlemen got their skills. In &quot;Danny Coughlin''s Bad Dream,&quot; a brief and unprecedented psychic flash upends dozens of lives, Danny''s most catastrophically. In &quot;Rattlesnakes,&quot; a sequel to Cujo, a grieving widower travels to Florida for respite and instead receives an unexpected inheritance--with major strings attached. In &quot;The Dreamers,&quot; a taciturn Vietnam vet answers a job ad and learns that there are some corners of the universe best left unexplored. &quot;The Answer Man&quot; asks if prescience is good luck or bad and reminds us that a life marked by unbearable tragedy can still be meaningful.<br>King''s ability to surprise, amaze, and bring us both terror and solace remains unsurpassed. Each of these stories holds its own thrills, joys, and mysteries; each feels iconic. You like it darker? You got it.</p>',N'English','2013-05-21',N'You-Like-It-Darker.jpg',7,27.90,512,8),
	(N'Pet Sematary',N'<p>When Dr. Louis Creed takes a new job and moves his family to the idyllic rural town of Ludlow, Maine, this new beginning seems too good to be true. Despite Ludlow''s tranquility, an undercurrent of danger exists here. Those trucks on the road outside the Creed''s beautiful old home travel by just a little too quickly, for one thing...as is evidenced by the makeshift graveyard in the nearby woods where generations of children have buried their beloved pets. Then there are the warnings to Louis both real and from the depths of his nightmares that he should not venture beyond the borders of this little graveyard where another burial ground lures with seductive promises and ungodly temptations. A blood-chilling truth is hidden there--one more terrifying than death itself, and hideously more powerful. As Louis is about to discover for himself sometimes, dead is better...</p>',N'English','2022-02-01',N'Pet-Sematary.jpg',7,16.74,416,10),
	(N'The Hollow Places',N'<p>A young woman discovers a strange portal in her uncle''s house, leading to madness and terror in this gripping new novel from the author of the &quot;innovative, unexpected, and absolutely chilling&quot; (Mira Grant, Nebula Award-winning author) The Twisted Ones.Pray they are hungry. Kara finds the words in the mysterious bunker that she''s discovered behind a hole in the wall of her uncle''s house. Freshly divorced and living back at home, Kara now becomes obsessed with these cryptic words and starts exploring this peculiar area--only to discover that it holds portals to countless alternate realities. But these places are haunted by creatures that seem to hear thoughts...and the more one fears them, the stronger they become. With her distinctive &quot;delightfully fresh and subversive&quot; (SF Bluestocking) prose and the strange, sinister wonder found in Guillermo del Toro''s Pan''s Labyrinth, The Hollow Places is another compelling and white-knuckled horror novel that you won''t be able to put down.</p>',N'English','2023-10-06', N'The-Hollow-Places.jpg',10,16.73,352,10),
	(N'Black Liturgies',N'<p>For years, Cole Arthur Riley was desperate for a spirituality she could trust. Amid ongoing national racial violence, the isolation of the pandemic, and a surge of anti-Black rhetoric in many Christian spaces, she began dreaming of a more human, more liberating expression of faith. She went on to create Black Liturgies, a digital project that connects spiritual practice with Black emotion, Black memory, and the Black body.<br>In this book, she brings together hundreds of new prayers, along with letters, poems, meditation questions, breath practices, scriptures, and the writings of Black literary ancestors to offer forty-three liturgies that can be practiced individually or as a community. Inviting readers to reflect on their shared experiences of wonder, rest, rage, and repair, and creating rituals for holidays like Lent and Juneteenth, Arthur Riley writes with a poet''s touch and a sensitivity that has made her one of the most important spiritual voices at work today.<br>For anyone healing from communities that were more violent than loving; for anyone who has escaped the trauma of white Christian nationalism, religious homophobia, or transphobia; for anyone asking what it means to be human in a world of both beauty and terror, Black Liturgies is a work of healing and empowerment, and a vision for what might be.</p>',N'English','2024-01-16', N'Black-Liturgies.jpg',10,20.46,336,11),
	(N'Worthy',N'<p>Imagine what you''d do if you FULLY believed in YOU! When you stop doubting your greatness, build unshakable self-worth and embrace who you are, you transform your entire life! WORTHY teaches you how, with simple steps that lead to life-changing results!<br>&quot;In life, you don''t soar to the level of your hopes and dreams, you stay stuck at the level of your self-worth. In your business, leadership, relationships, friendships and ambitions, you don''t rise to what you believe is possible, you fall to what you believe you''re worthy of. When you build your self-worth, you change your entire life. WORTHY teaches you how. I wrote WORTHY for YOU if you have some self-doubt to destroy and a destiny to fulfill!&quot; - Jamie Kern Lima</p>',N'English','2024-02-20', N'Worthy.jpg',10,25.11,352,12),
	(N'Grief and Grit(s)',N'<p>&quot;In times of unprecedented panic, we see what we''re really made of.<br>Though the worldwide pandemic affected each of us differently, this time of turmoil brought one thing into stark clarity: the value of human life. When tragedy begets triaging and certain demographics are seen as more disposable than others, what does that say about our society? And what does it say about us?<br>This is a story about America, about how we view the most vulnerable people in our society--our aging and elderly--both in times of crisis and in our everyday lives.<br>This is also a story about a mother and daughter, of a mother raising her daughter in love, faith, and confidence, then the bizarre role-reversal as that mother deteriorated to the helplessness of a child. Nothing can prepare you for that intensity of sorrow and joy.<br>Nothing can prepare you for what happens when the coroner refuses to show up and pronounce your mother legally dead, either.<br>In this stunning debut, author Marsha Hill invites you into a personal look at an uncomfortable truth: how we treat our elderly today defines our own future. Full of tragedy and triumph, laughter and tears, grief and--yes, some good, old-fashioned grits--Grief and Grit(s) is not only a reflection of the life and tragic death of Adaline Gray, but the power of our generation to fight for human dignity at every stage of life.&quot;</p>',N'English','2024-02-13', N'Grief-and-Grit(s).jpg',10,24.18,224,13),
	(N'Dear Black Girls: How to Be True to You',N'<p>This is for my Black girls.<br>Despite gold medals, WNBA championships, and a list of accolades, A''ja Wilson knows how it feels to be swept under the rug--to not be heard, to not feel seen, to not be taken seriously. As a fourth grader going to a primarily white school in South Carolina, A''ja was told she''d have to stay outside for a classmate''s birthday party. &quot;Huh?&quot; she asked. Because the birthday girl''s father didn''t like Black people.<br>Wilson tells stories like this, about how even when life tried to hold her down, it didn''t stop her. She shares her contribution to &quot;The Talk,&quot; and how to keep fighting, all while igniting strength, passion, and joy. Dear Black Girls is a necessary and meaningful exploration of what it means to be a Black woman in America today--and a rallying cry to lift up women and girls everywhere.<br>&quot;&#8203;D&#8203;ear Black Girls is filled with phenomenal stories and empowering insight on what it means to be a woman in today''s world. I didn''t want to put it down.&quot;</p>',N'English','2024-02-06', N'Dear-Black-Girls.jpg',10,23.24,192,14),
	(N'Be a Revolution',N'<p>&quot;In the #1 New York Times bestseller So You Want To Talk About Race, Ijeoma Oluo offered a vital guide for how to talk about important issues of race and racism in society. In Mediocre: The Dangerous Legacy of White Male America, she discussed the ways in which white male supremacy has had an impact on our systems, our culture, and our lives throughout American history. But now that we better understand these systems of oppression, the question is this: What can we do about them?</p><p>With Be A Revolution: How Everyday People are Fighting Oppression and Changing the World--and How You Can, Too, Oluo aims to show how people across America are working to create real positive change in our structures. Looking at many of our most powerful systems--like education, media, labor, health, housing, policing, and more--she highlights what people are doing to create change for intersectional racial equity. She also illustrates various ways in which the reader can find entryways into change in these same areas, or can bring some of this important work being done elsewhere to where they live.</p><p>This book aims to not only be educational, but to inspire action and change. Oluo wishes to take our conversations on race and racism out of a place of pure pain and trauma, and into a place of loving action. Be A Revolution is both an urgent chronicle of this important moment in history, as well as an inspiring and restorative call for action.&quot;</p>',N'English','2024-01-30', N'Be-a-Revolution.jpg',10,25.10,416,15),
	(N'All about Love: New Visions',N'<p>&quot;The word ''love'' is most often defined as a noun, yet we would all love better if we used it as a verb,&quot; writes bell hooks as she comes out fighting and on fire in All About Love. Here, at her most provocative and intensely personal, renowned scholar, cultural critic and feminist bell hooks offers a proactive new ethic for a society bereft with lovelessness--not the lack of romance, but the lack of care, compassion, and unity. People are divided, she declares, by society''s failure to provide a model for learning to love.</p><p>As bell hooks uses her incisive mind to explore the question &quot;What is love?&quot; her answers strike at both the mind and heart. Razing the cultural paradigm that the ideal love is infused with sex and desire, she provides a new path to love that is sacred, redemptive, and healing for individuals and for a nation. The Utne Reader declared bell hooks one of the &quot;100 Visionaries Who Can Change Your Life.&quot; All About Love is a powerful, timely affirmation of just how profoundly her revelations can change hearts and minds for the better.</p>',N'English','2018-01-30', N'All-about-Love.jpg',10,15.80,272,16),
	(N'Color Charts: A History',N'<p>The need to categorize and communicate color has mobilized practitioners and scholars for centuries. Color Charts describes the many different methods and ingenious devices developed since the fifteenth century by doctors, naturalists, dyers, and painters to catalog fragments of colors. With the advent of industrial society, manufacturers and merchants developed some of the most beautiful and varied tools ever designed to present all the available colors. Thanks to them, society has discovered the abundance of color embodied in a plethora of materials: cuts of fabric, leather, paper, and rubber; slats of wood and linoleum; delicate skeins of silk; careful deposits of paint and pastels; fragments of lipstick; and arrangements of flower petals. These samples shape a visual culture and a chromatic vocabulary and instill a deep desire for color.<br>Anne Varichon traces the emergence of modern color charts from a set of processes developed over the centuries in various contexts. She presents illuminating examples that bring this remarkable story to life, from ancient writings revealing attention to precise shade to contemporary designers'' color charts, dyers'' notebooks, and Werner''s famous color nomenclature. Varichon argues that color charts have linked generations of artists, artisans, scientists, industrialists, and merchants, and have played an essential and enduring role in the way societies think about color.<br>Drawing on nearly two hundred documents from public and private collections, almost all of them previously unpublished, this wonderfully illustrated book shows how the color chart, in its many distinct forms and expressions, is a practical tool that has transcended its original purpose to become an educational aid and subject of contemplation worthy of being studied and admired.</p>',N'English','2024-02-06',N'Color-Charts.jpg',10,51.15,284,17),
	(N'Math in Drag',N'<p>&quot;Join sensational drag queen Kyne Santos on an extraordinary journey through the glamorous world of . . . math?<br>This sassy book is your VIP pass, taking you behind the scenes with a TikTok superstar who shatters stereotypes and proves that math can be fascinating and fun, even for people who think they aren''t good at it.<br>With her irreverent style and unique perspective, Kyne investigates mathematical mysteries while educating us about the art of drag. She explores surprising connections, such as the elegance of ballroom culture and the nature of infinity, the rebellious joys of Pride and dividing by zero, and the role of statistics in her own experience on Drag Race. Kyne gets personal while sharing her experiences as a queer person forging a path in STEM, overcoming obstacles to stay fierce, stay real, and thrive! She empowers readers of all skill levels to break school rules, question everything, and embrace math''s beauty.<br>In Math in Drag, numbers glitter, equations sashay through history, and inclusivity is a celebration. Read it to fire your excitement and unleash your inner math diva!&quot;</p>',N'English','2024-03-05',N'Math-in-Drag.jpg',10,23.20,280,18),
	(N'Younger for Life',N'<p>From bestselling author and beloved social media star Dr. Anthony Youn comes a revolutionary step-by-step guide to reversing the effects of aging at any stage in life</p><p>Growing older is a blessing. But the slow decline and the loss of functionality associated with aging has led us to treat the process like a disease. These negative effects of aging, however, are not inevitable. Rather, they''re largely the result of environmental and lifestyle factors that, when properly addressed, can be reversed through a process called Autojuvenation(TM).</p><p>Dr. Youn, one of America''s most trusted surgeons, offers a groundbreaking new approach to turning back the clock naturally. In this step-by-step guide, he shows us how, through simple changes in diet, activity and skin care, we can look younger than ever before.</p>',N'English','2024-01-02', N'Younger-for-Life.jpg',10,27.90,384,19),
	(N'Wild Urban Plants of the Northeast',N'<p>In this field guide to the future, esteemed Harvard University botanist Peter Del Tredici unveils the plants that will become even more dominant in urban environments under projected future environmental conditions. These plants are the most important and most common plants in cities. Learning what they are and the role they play, he writes, will help us all make cities more livable and enjoyable.</p><p>With more than 1000 photos, readers can easily identify these powerful plants. Learn about the fascinating cultural history of each plant.</p>',N'English','2020-03-15', N'Wild-Urban-Plants-of-the-Northeast.jpg',10,32.50,428,20),
	(N'The Food Lab',N'<p>Ever wondered how to pan-fry a steak with a charred crust and an interior that''s perfectly medium-rare from edge to edge when you cut into it? How to make homemade mac ''n'' cheese that is as satisfyingly gooey and velvety-smooth as the blue box stuff, but far tastier? How to roast a succulent, moist turkey (forget about brining!)--and use a foolproof method that works every time?</p><p>As Serious Eats''s culinary nerd-in-residence, J. Kenji L&oacute;pez-Alt has pondered all these questions and more. In The Food Lab, Kenji focuses on the science behind beloved American dishes, delving into the interactions between heat, energy, and molecules that create great food. Kenji shows that often, conventional methods don''t work that well, and home cooks can achieve far better results using new--but simple--techniques. In hundreds of easy-to-make recipes with over 1,000 full-color images, you will find out how to make foolproof Hollandaise sauce in just two minutes, how to transform one simple tomato sauce into a half dozen dishes, how to make the crispiest, creamiest potato casserole ever conceived, and much more.</p>',N'English','2015-09-21', N'The-Food-Lab.jpg',10,46.45,960,21),
	(N'How Far the Light Reaches',N'<p>A queer, mixed race writer working in a largely white, male field, science and conservation journalist Sabrina Imbler has always been drawn to the mystery of life in the sea, and particularly to creatures living in hostile or remote environments. Each essay in their debut collection profiles one such creature, including:</p><p>-the mother octopus who starves herself while watching over her eggs,</p><p>-the Chinese sturgeon whose migration route has been decimated by pollution and dams,</p><p>-the bizarre, predatory Bobbitt worm (named after Lorena),</p><p>-the common goldfish that flourishes in the wild,</p><p>-and more.</p><p>Imbler discovers that some of the most radical models of family, community, and care can be found in the sea, from gelatinous chains that are both individual organisms and colonies of clones to deep-sea crabs that have no need for the sun, nourished instead by the chemicals and heat throbbing from the core of the Earth. Exploring themes of adaptation, survival, sexuality, and care, and weaving the wonders of marine biology with stories of their own family, relationships, and coming of age, How Far the Light Reaches is a shimmering, otherworldly debut that attunes us to new visions of our world and its miracles.</p>',N'English','2022-12-06', N'How-Far-the-Light-Reaches.jpg',10,26.04,272,22),
	(N'The Art of Doing Science and Engineering',N'<p>What inspires and spurs on a great idea? Can we train ourselves to think in a way that will enable world-changing understandings and insights to emerge?<br>Richard Hamming said we can. He first inspired a generation of engineers, scientists, and researchers in 1986 with &quot;You and Your Research,&quot; an electrifying sermon on why some scientists do great work, why most don''t, why he did, and why you can--and should--too. The Art of Doing Science and Engineering is the full expression of what &quot;You and Your Research&quot; outlined. It''s a book about thinking; more specifically, a style of thinking by which great ideas are conceived.<br>The book is filled with stories of great people performing mighty deeds--but they are not meant simply to be admired. Instead, they are to be aspired to, learned from, and surpassed. Hamming consistently returns to Shannon''s information theory, Einstein''s theory of relativity, Grace Hopper''s work on high-level programming, Kaiser''s work on digital fillers, and his own work on error-correcting codes. He also recounts a number of his spectacular failures as clear examples of what to avoid.<br>Originally published in 1996 and adapted from a course that Hamming taught at the US Naval Postgraduate School, this edition includes an all-new foreword by designer, engineer, and founder of Dynamicland Bret Victor, plus more than 70 redrawn graphs and charts.<br>The Art of Doing Science and Engineering is a reminder that a capacity for learning and creativity are accessible to everyone. Hamming was as much a teacher as a scientist, and having spent a lifetime forming and confirming a theory of great people and great ideas, he prepares the next generation for even greater distinction.</p>',N'English','2020-05-26', N'The-Art-of-Doing-Science-and-Engineering.jpg',10,21.39,432,23),
	(N'Why We Sleep: Unlocking the Power of Sleep and Dreams',N'<p>With two appearances on CBS This Morning and Fresh Air''s most popular interview of 2017, Matthew Walker has made abundantly clear that sleep is one of the most important but least understood aspects of our life. Until very recently, science had no answer to the question of why we sleep, or what good it served, or why we suffer such devastating health consequences when it is absent. Compared to the other basic drives in life--eating, drinking, and reproducing--the purpose of sleep remains more elusive.<br>Within the brain, sleep enriches a diversity of functions, including our ability to learn, memorize, and make logical decisions. It recalibrates our emotions, restocks our immune system, fine-tunes our metabolism, and regulates our appetite. Dreaming creates a virtual reality space in which the brain melds past and present knowledge, inspiring creativity.<br>In this &quot;compelling and utterly convincing&quot; (The Sunday Times) book, preeminent neuroscientist and sleep expert Matthew Walker provides a revolutionary exploration of sleep, examining how it affects every aspect of our physical and mental well-being. Charting the most cutting-edge scientific breakthroughs, and marshalling his decades of research and clinical practice, Walker explains how we can harness sleep to improve learning, mood and energy levels, regulate hormones, prevent cancer, Alzheimer''s and diabetes, slow the effects of aging, and increase longevity. He also provides actionable steps towards getting a better night''s sleep every night.</p>',N'English','2018-06-19',N'Why-We-Sleep.jpg',10,16.74,368,8),
	(N'How Emotions Are Made',N'<p>Preeminent psychologist Lisa Barrett lays out how the brain constructs emotions in a way that could revolutionize psychology, health care, the legal system, and our understanding of the human mind.<br>&quot;Fascinating . . . A thought-provoking journey into emotion science.&quot;--The Wall Street Journal<br>&quot;A singular book, remarkable for the freshness of its ideas and the boldness and clarity with which they are presented.&quot;--Scientific American<br>&quot;A brilliant and original book on the science of emotion, by the deepest thinker about this topic since Darwin.&quot;--Daniel Gilbert, best-selling author of Stumbling on Happiness<br>The science of emotion is in the midst of a revolution on par with the discovery of relativity in physics and natural selection in biology. Leading the charge is psychologist and neuroscientist Lisa Feldman Barrett, whose research overturns the long-standing belief that emotions are automatic, universal, and hardwired in different brain regions. Instead, Barrett shows, we construct each instance of emotion through a unique interplay of brain, body, and culture.<br>A lucid report from the cutting edge of emotion science, How Emotions Are Made reveals the profound real-world consequences of this breakthrough for everything from neuroscience and medicine to the legal system and even national security, laying bare the immense implications of our latest and most intimate scientific revolution.</p>',N'English','2018-03-13',N'How-Emotions-Are-Made.jpg ',10,18.59,448,24),
	(N'House of Sky and Breath',N'<p>Bryce Quinlan and Hunt Athalar are trying to get back to normal--they may have saved Crescent City, but with so much upheaval in their lives lately, they mostly want a chance to relax. Slow down. Figure out what the future holds.<br>The Asteri have kept their word so far, leaving Bryce and Hunt alone. But with the rebels chipping away at the Asteri''s power, the threat the rulers pose is growing. As Bryce, Hunt, and their friends get pulled into the rebels'' plans, the choice becomes clear: stay silent while others are oppressed, or fight for what''s right. And they''ve never been very good at staying silent.<br>In this sexy, action-packed sequel to the #1 bestseller House of Earth and Blood, Sarah J. Maas weaves a captivating story of a world about to explode--and the people who will do anything to save it.</p>',N'English','2022-02-15', N'House-of-Sky-and-Breath.jpg',10,29.76,768,1),
	(N'Your Utopia: Stories',N'<p>In &quot;The Center for Immortality Research,&quot; a low-level employee runs herself ragged planning a fancy gala for donors, only to be blamed for a crime she witnessed during the event, under the noses of the mysterious celebrity benefactors hoping to live forever. But she can''t be fired--no one can. In &quot;One More Kiss, Dear,&quot; a tender, one-sided love blooms in the AI-elevator of an apartment complex; as in, the elevator develops a profound affection for one of the residents. In &quot;Seeds,&quot; we see the final frontier of capitalism''s destruction of the planet and the GMO companies who rule the agricultural industry, but nature has ways of creeping back to life.<br>Chung''s writing is &quot;haunting, funny, gross, terrifying--and yet when we reach the end, we just want more&quot; (Alexander Chee). If you haven''t yet experienced the fruits of this singular imagination, Your Utopia is waiting.<br>&quot;Nothing concentrates the mind like Chung''s terrors, which will shrivel you to a bouillon cube of your most primal instincts&quot; (Vulture), yet these stories are suffused with Chung''s inimitable wry humor and surprisingly tender moments, too.</p>',N'English','2024-01-30',N'Your-Utopia.jpg',10,17.66,256,25),
	(N'Gideon the Ninth',N'<p>The Emperor needs necromancers.<br>The Ninth Necromancer needs a swordswoman.<br>Gideon has a sword, some dirty magazines, and no more time for undead nonsense.<br>Tamsyn Muir''s Gideon the Ninth, first in The Locked Tomb Trilogy, unveils a solar system of swordplay, cut-throat politics, and lesbian necromancers. Her characters leap off the page, as skillfully animated as arcane revenants. The result is a heart-pounding epic science fantasy.<br>Brought up by unfriendly, ossifying nuns, ancient retainers, and countless skeletons, Gideon is ready to abandon a life of servitude and an afterlife as a reanimated corpse. She packs up her sword, her shoes, and her dirty magazines, and prepares to launch her daring escape. But her childhood nemesis won''t set her free without a service.<br>Harrowhark Nonagesimus, Reverend Daughter of the Ninth House and bone witch extraordinaire, has been summoned into action. The Emperor has invited the heirs to each of his loyal Houses to a deadly trial of wits and skill. If Harrowhark succeeds she will be become an immortal, all-powerful servant of the Resurrection, but no necromancer can ascend without their cavalier. Without Gideon''s sword, Harrow will fail, and the Ninth House will die.</p>',N'English','2020-07-14',N'Gideon-the-Ninth.jpg',10,17.66,496,26),
	(N'Nona the Ninth',N'<p>Her city is under siege.<br>The zombies are coming back.<br>And all Nona wants is a birthday party.<br>In many ways, Nona is like other people. She lives with her family, has a job at her local school, and loves walks on the beach and meeting new dogs. But Nona''s not like other people. Six months ago she woke up in a stranger''s body, and she''s afraid she might have to give it back.<br>The whole city is falling to pieces. A monstrous blue sphere hangs on the horizon, ready to tear the planet apart. Blood of Eden forces have surrounded the last Cohort facility and wait for the Emperor Undying to come calling. Their leaders want Nona to be the weapon that will save them from the Nine Houses. Nona would prefer to live an ordinary life with the people she loves, with Pyrrha and Camilla and Palamedes, but she also knows that nothing lasts forever.<br>And each night, Nona dreams of a woman with a skull-painted face...</p>',N'English','2023-09-12', N'Nona-the-Ninth.jpg',10,18.59,512,26),
	(N'The Three-Body Problem',N'<p>The Three-Body Problem is the first chance for English-speaking readers to experience the Hugo Award-winning phenomenon from China''s most beloved science fiction author, Liu Cixin.<br>Set against the backdrop of China''s Cultural Revolution, a secret military project sends signals into space to establish contact with aliens. An alien civilization on the brink of destruction captures the signal and plans to invade Earth. Meanwhile, on Earth, different camps start forming, planning to either welcome the superior beings and help them take over a world seen as corrupt, or to fight against the invasion. The result is a science fiction masterpiece of enormous scope and vision.</p>',N'English','2016-01-12', N'The-Three-Body-Problem.jpg',10,17.66,416,27),
	(N'Death''s End',N'<p>With The Three-Body Problem, English-speaking readers got their first chance to read China''s most beloved science fiction author, Cixin Liu. The Three-Body Problem was released to great acclaim including coverage in The New York Times and The Wall Street Journal and reading list picks by Barack Obama and Mark Zuckerberg. It was also won the Hugo and Nebula Awards, making it the first translated novel to win a major SF award.<br>Now this epic trilogy concludes with Death''s End. Half a century after the Doomsday Battle, the uneasy balance of Dark Forest Deterrence keeps the Trisolaran invaders at bay. Earth enjoys unprecedented prosperity due to the infusion of Trisolaran knowledge. With human science advancing daily and the Trisolarans adopting Earth culture, it seems that the two civilizations will soon be able to co-exist peacefully as equals without the terrible threat of mutually assured annihilation. But the peace has also made humanity complacent.<br>Cheng Xin, an aerospace engineer from the early twenty-first century, awakens from hibernation in this new age. She brings with her knowledge of a long-forgotten program dating from the beginning of the Trisolar Crisis, and her very presence may upset the delicate balance between two worlds. Will humanity reach for the stars or die in its cradle?</p>',N'English','2017-09-05', N'Death_s-End.jpg',10,17.66,624,27),
	(N'The Dark Forest',N'<p>In The Dark Forest, Earth is reeling from the revelation of a coming alien invasion-in just four centuries'' time. The aliens'' human collaborators may have been defeated, but the presence of the sophons, the subatomic particles that allow Trisolaris instant access to all human information, means that Earth''s defense plans are totally exposed to the enemy. Only the human mind remains a secret. This is the motivation for the Wallfacer Project, a daring plan that grants four men enormous resources to design secret strategies, hidden through deceit and misdirection from Earth and Trisolaris alike. Three of the Wallfacers are influential statesmen and scientists, but the fourth is a total unknown. Luo Ji, an unambitious Chinese astronomer and sociologist, is baffled by his new status. All he knows is that he''s the one Wallfacer that Trisolaris wants dead.</p>',N'English','2016-08-16',N'The-Dark-Forest.jpg',10,17.66,528,27),
	(N'The Deluge',N'<p>In the first decades of the 21st century, the world is convulsing, its governments mired in gridlock while a patient but unrelenting ecological crisis looms. America is in upheaval, battered by violent weather and extreme politics. In California in 2013, Tony Pietrus, a scientist studying deposits of undersea methane, receives a death threat. His fate will become bound to a stunning cast of characters--a broken drug addict, a star advertising strategist, a neurodivergent mathematician, a cunning eco-terrorist, an actor turned religious zealot, and a brazen young activist named Kate Morris, who, in the mountains of Wyoming, begins a project that will alter the course of the decades to come.<br>From the Gulf Coast to Los Angeles, the Midwest to Washington, DC, their intertwined odysseys unfold against a stark backdrop of accelerating chaos as they summon courage, galvanize a nation, fall to their own fear, and find wild hope in the face of staggering odds. As their stories hurtle toward a spectacular climax, each faces a reckoning: what will they sacrifice to salvage humanity''s last chance at a future? A singular achievement, The Deluge is a once-in-a-generation novel that meets the moment as few works of art ever have.</p>',N'English','2023-01-10', N'The-Deluge.jpg',10,30.23,896,28),
	(N'Babylon''s Ashes',N'<p>A revolution brewing for generations has begun in fire. It will end in blood.<br>The Free Navy -- a violent group of Belters in black-market military ships -- has crippled the Earth and begun a campaign of piracy and violence among the outer planets. The colony ships heading for the thousand new worlds on the far side of the alien ring gates are easy prey, and no single navy remains strong enough to protect them.<br>James Holden and his crew know the strengths and weaknesses of this new force better than anyone. Outnumbered and outgunned, the embattled remnants of the old political powers call on the Rocinante for a desperate mission to reach Medina Station at the heart of the gate network.<br>But the new alliances are as flawed as the old, and the struggle for power has only just begun.</p>',N'English','2021-10-24', N'Babylon_s-Ashes.jpg',10,18.59,576,29),
	(N'The Every',N'<p>Delaney Wells is an unlikely new hire at the Every. A former forest ranger and unwavering tech skeptic, she charms her way into an entry-level job with one goal in mind: to take down the company from within. With her compatriot, the not-at-all-ambitious Wes Makazian, they look for the Every''s weaknesses, hoping to free humanity from all-encompassing surveillance and the emoji-driven infantilization of the species. But does anyone want what Delaney is fighting to save? Does humanity truly want to be free?<br>Studded with unforgettable characters, outrageous outfits, and lacerating set-pieces, this companion to The Circle blends absurdity and terror, satire and suspense, while keeping the reader in apprehensive excitement about the fate of the company--and the human animal.<br></p>',N'English','2021-11-16', N'The-Every.jpg',10,16.69,608,30),
	(N'Get the Picture',N'<p>The New York Times bestselling author of Cork Dork takes readers on another fascinating, hilarious, and revelatory journey--this time burrowing deep inside the secretive world of art and artists<br>An award-winning journalist obsessed with obsession, Bianca Bosker''s existence was upended when she wandered into the art world--and couldn''t look away. Intrigued by artists who hyperventilate around their favorite colors and art fiends who max out credit cards to show hunks of metal they think can change the world, Bosker grew fixated on understanding why art matters and how she--or any of us--could engage with it more deeply.<br>In Get the Picture, Bosker throws herself into the nerve center of art and the people who live for it: gallerists, collectors, curators, and, of course, artists themselves--the kind who work multiple jobs to afford their studios while scrabbling to get eyes on their art. As she stretches canvases until her fingers blister, talks her way into A-list parties full of billionaire collectors, has her face sat on by a nearly-naked performance artist, and forces herself to stare at a single sculpture for hours on end while working as a museum security guard, she discovers not only the inner workings of the art-canonization machine but also a more expansive way of living.<br>Probing everything from cave paintings to Instagram, and from the science of sight to the importance of beauty as it examines art''s role in our culture, our economy, and our hearts, Get the Picture is a rollicking adventure that will change the way you see forever.</p>',N'English','2024-02-06', N'Get-the-Picture.jpg',10,26.97,384,31),
	(N'Make Art or Die Trying',N'<p>Multidisciplinary artist, entrepreneur, and activist Stuart Semple believes that art is for everyone, and that everyone is an artist. Every single human has an inner spark of creativity that can make the world a better place. Art can change people, places, attitudes, and communities, healing and communicating when words aren''t enough.<br>Make Art or Die Trying empowers you to understand and connect with big art ideas and embrace your creative potential, no matter where you''re starting from. This stunning, informative, and inspiring book demystifies influential art concepts of the 20th and 21st centuries, including happenings, performance art, Bauhaus, and Fluxus, making them super-approachable and inviting you to learn, make art, and make change.</p>',N'English','2023-6-11', N'Make-Art-or-Die-Trying.jpg',10,27.90,208,32),
	(N'Watercolor Your Way',N'<p>Watercolor Your Way meets you right where you are with watercolor. Whether you''re dipping your toe in, cannon-balling in, or honing your craft--this book is for you.<br>Written and illustrated by artist Sarah Cray, co-founder of the art education platform Let''s Make Art, Watercolor Your Way is designed to inform and guide you at your current skill level.<br>Each of four chapters focuses on different techniques and supplies, building on each other so you can bring your watercolor art to the next level. Instead of presenting everything about paints, color mixing, and techniques all at once, it''s offered in four small installments, with frequently asked questions, pro tips, and projects geared toward where you are on your artistic path, so you can get to the fun part--creating with watercolor--faster!</p>',N'English','2024-3-05', N'Watercolor-Your-Way.jpg',10,21.38,128,33),
	(N'Camo',N'<p>As the sole woman operating in the male-dominated advertising photography industry in Kenya, Thandiwe Muriu has repeatedly confronted questions around the role of women in society, the place of tradition, and her own self-perception. These experiences inspired her personal project of cultural reflection: the Camo series. Camo was the catalyst for her to push new boundaries in her photography, leading her into a deeply personal artistic journey.<br>The compelling, fully saturated photographs in this collection confront issues surrounding identity while seeking to redefine female empowerment through Muriu''s choice of materials. These constructed images are not digital manipulations but physical sets that incorporate African Ankara wax textiles as backdrops and custom-tailored clothing and headdresses. At the forefront of her practice is using textiles to make her subjects disappear and serve as a canvas for reflection on the question of identity and its evolution over time. Muriu also consistently reimagines common objects associated with the daily lives of Kenyans into bold accessories donned by her subjects. These objects range from hairpins to the mosquito-repellent coils she grew up using. In Kenya, an object can have multiple uses beyond its original purpose; as Muriu explains, &quot;When you have little, you transform and reuse it.&quot;<br>Throughout the book, each image is paired with an inspirational African proverb in both English and Swahili, expressing the collected wisdom of generations that continue to inspire. Proverbs such as &quot;With a little seed of imagination, you can grow a field of hope&quot; convey the uplifting spirit of Muriu''s work that empowers women, preserves tradition, and celebrates African beauty and culture.</p>',N'English','2023-4-16', N'Camo.jpg',10,37.20,224,34),
	(N'What''s Wrong?',N'<p>What''s Wrong? is author, illustrator, and scientific researcher Erin Williams''s graphic exploration of how the American health-care system fails us. Focusing on four raw and complex firsthand accounts, plus Williams''s own story, this book examines the consequences of living with interconnected illnesses and conditions like: immunodeficiency, cancer, endometriosis, alcoholism, severe depression, PTSD<br>Western medicine, which intends to cure illness and minimize pain, often causes more loss, abuse, and suffering for those Americans who don''t fit within the narrow definition of who the system was built to serve--cis, white, heterosexual men. The book explores the many ways in which those receiving medical care are often overlooked, unseen, and doubted by the very clinicians who are supposed to heal them. What''s Wrong? is also a beautiful celebration of nontraditional modes of healing, of how we become whole not because of health care but despite it.</p>',N'English','2024-01-23', N'What_s-Wrong_.jpg',10,27.89,256,35),
	(N'The Reverse Coloring Book',N'<p>The book has the colors, you draw the lines: the creative possibilities are endless!<br>Reverse coloring is a totally new idea in creativity and mindfulness: so simple, and so profoundly satisfying. Artist Kendra Norton created these beautiful and whimsical unfinished watercolors to provide a gentle visual guide for your own creativity and exploration.<br>Trace the shapes, draw in figures, doodle, shade, cover an area with dots. Each page is an invitation to slow down, let your mind drift, and be surprised by your own creativity. And because reverse coloring requires no &quot;staying inside the lines,&quot; it empowers your artistic self-confidence while it calms the mind.<br>The Reverse Coloring Book(TM) includes 50 original works of art, printed on sturdy paper that''s single-sided and perforated. All you need is a pen.</p>',N'English','2021-8-31', N'The-Reverse-Coloring-Book.jpg',10,13.90,104,36);

----------------------
INSERT INTO Genre
VALUES
('Romance'),
('Horror'),
('Self Development & Hobbies'),
('Science & Technology'),
('Science Fiction'),
('Arts & Photography'),
('Fantasy');


-------------------------
insert into BookGenre
VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,2),
(12,2),
(13,2),
(14,2),
(15,2),
(16,2),
(17,2),
(18,2),
(19,2),
(20,3),
(21,3),
(22,3),
(23,3),
(24,3),
(25,3),
(26,3),
(27,4),
(28,4),
(29,4),
(30,4),
(31,4),
(32,4),
(33,4),
(34,4),
(35,5),
(36,5),
(37,5),
(38,5),
(39,5),
(40,5),
(41,5),
(42,5),
(43,5),
(44,5),
(45,6),
(46,6),
(47,6),
(48,6),
(49,6),
(50,6);

-------------------------------------
Insert into BookAuthor
values
(1,1),
(2,1),
(3,1),
(4,2),
(5,3),
(6,4),
(7,3),
(8,5),
(9,6),
(10,3),
(11,7),
(12,8),
(13,9),
(14,7),
(15,10),
(16,11),
(17,10),
(18,10),
(19,7),
(20,12),
(21,13),
(22,14),
(23,15),
(24,16),
(25,17),
(26,18),
(27,19),
(28,20),
(29,21),
(30,22),
(31,23),
(32,24),
(33,25),
(34,26),
(35,1),
(36,11),
(37,27),
(38,27),
(39,28),
(40,28),
(41,28),
(42,29),
(43,30),
(44,31),
(45,32),
(46,33),
(47,34),
(48,35),
(49,36),
(50,37);


-----------Insert ShopOrder-----------------
INSERT INTO ShopOrder (orderDate, orderStatus, userID) VALUES ('2024-03-07', 'Done', '1');
INSERT INTO ShopOrder (orderDate, orderStatus, userID) VALUES ('2024-03-07', 'Done', '1');
INSERT INTO ShopOrder (orderDate, orderStatus, userID) VALUES ('2024-03-07', 'Done', '1');
INSERT INTO ShopOrder (orderDate, orderStatus, userID) VALUES ('2024-03-08', 'Done', '2');
INSERT INTO ShopOrder (orderDate, orderStatus, userID) VALUES ('2024-03-08', 'Done', '2');



----------------Insert OrderLine-------------------------
-- Insert statements for OrderLine table
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (6, 1, 3, 15.76);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (9, 1, 1, 17.66);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (8, 1, 1, 25.11);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (2, 1, 1, 17.67);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (21, 2, 1, 25.11);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (28, 2, 1, 27.90);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (26, 2, 1, 51.15);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (31, 3, 1, 26.04);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (33, 3, 1, 16.74);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (35, 3, 1, 29.76);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (2, 4, 19, 17.67);
INSERT INTO OrderLine (bookID, orderID, quantity, price) VALUES (4, 5, 1, 26.97);
