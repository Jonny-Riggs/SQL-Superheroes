-- DELETE FROM SuperheroPower;
-- DELETE FROM Power;
-- DELETE FROM PowerType;
-- DELETE FROM SuperheroWeakness;
-- DELETE FROM Weakness;
-- DELETE FROM Sidekick;
-- DELETE FROM Superhero;

-- DROP TABLE IF EXISTS Superhero;
-- DROP TABLE IF EXISTS Power;
-- DROP TABLE IF EXISTS PowerType;
-- DROP TABLE IF EXISTS SuperheroPower;
-- DROP TABLE IF EXISTS Sidekick;
-- DROP TABLE IF EXISTS Weakness;
-- DROP TABLE IF EXISTS SuperheroWeakness;



CREATE TABLE `Superhero` (
    `SuperheroId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `Gender`    TEXT NOT NULL,
    `Secret_ID`
);

INSERT INTO Superhero VALUES (null, 'Green Lantern', 'M', 'Green Room', 'Green', null);
INSERT INTO Superhero VALUES (null, 'Wonder Woman', 'F', 'Themyscira', 'Blue, Gold, Red', null);
INSERT INTO Superhero VALUES (null, 'Batman', 'M', 'Bat Cave', 'Grey', null);

CREATE TABLE `Sidekick` (
    `SidekickId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `Gender`    TEXT NOT NULL,
    `Profession`    TEXT NOT NULL,
    `SuperheroId`    INTEGER NOT NULL,
    FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`)
);

INSERT INTO Sidekick
  SELECT null, 'Robin', 'M', 'Neerdowell', SuperheroId
  FROM Superhero s
  WHERE s.Name = 'Batman';


CREATE TABLE `PowerType` (
    `PowerTypeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL
);

INSERT INTO PowerType VALUES (null, 'Physical');
INSERT INTO PowerType VALUES (null, 'Energy');


CREATE TABLE `Power` (
    `PowerId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `PowerTypeId`    INTEGER NOT NULL,
    FOREIGN KEY(`PowerTypeId`) REFERENCES `PowerType`(`PowerTypeId`)
);

INSERT INTO Power
  -- shortcut of sorts for adding a fk id to a table while searching for that id at the same time
  SELECT null, 'Super Strength', PowerTypeId
  FROM PowerType
  WHERE Name = 'Physical';

INSERT INTO Power
  SELECT null, 'Elasticity', PowerTypeId
  FROM PowerType
  WHERE Name = 'Physical';

INSERT INTO Power
  SELECT null, 'Laser Eyesight', PowerTypeId
  FROM PowerType
  WHERE Name = 'Energy';

INSERT INTO Power
  SELECT null, 'Storm Power', PowerTypeId
  FROM PowerType
  WHERE Name = 'Energy';

INSERT INTO Power
  SELECT null, 'Reality Manipulation', PowerTypeId
  FROM PowerType
  WHERE Name = 'Energy';

CREATE TABLE `SuperheroPower` (
    `SuperheroPowerId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `SuperheroId`    INTEGER NOT NULL,
    `PowerId`    INTEGER NOT NULL,
    FOREIGN KEY(`PowerId`) REFERENCES `Power`(`PowerId`),
    FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`)
);

INSERT INTO SuperheroPower
  SELECT null, s.SuperheroId, p.PowerId
  FROM Power p, Superhero s
  WHERE s.Name = 'Wonder Woman' and p.Name = "Super Strength";

INSERT INTO SuperheroPower
  SELECT null, s.SuperheroId, p.PowerId
  FROM Power p, Superhero s
  WHERE s.Name = 'Green Lantern' and p.Name = "Reality Manipulation";


CREATE TABLE `Weakness` (
    `WeaknessId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL
);

INSERT INTO Weakness VALUES (null, 'Yellow');

CREATE TABLE `SuperheroWeakness` (
    `SuperheroWeaknessId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `SuperheroId`    INTEGER NOT NULL,
    `WeaknessId`    INTEGER NOT NULL,
    FOREIGN KEY(`WeaknessId`) REFERENCES `Weakness`(`WeaknessId`),
    FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`)
);

INSERT INTO SuperheroWeakness
  SELECT null, s.SuperheroId, w.WeaknessId
  FROM Weakness w, Superhero s
  WHERE s.Name = 'Green Lantern' and w.Name = "Yellow";