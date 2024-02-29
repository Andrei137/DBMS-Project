-- Exercitiul 4
-- CREATE TABLE
CREATE TABLE UTILIZATOR
(
    cod_utilizator NUMBER(7) constraint pkey_utilizator PRIMARY KEY,
    nume VARCHAR2(30) constraint nume_utilizator NOT NULL,
    prenume VARCHAR2(30) constraint prenume_utilizator NOT NULL,
    parola VARCHAR(30) constraint parola_utilizator NOT NULL,
    email VARCHAR2(30) constraint email_valid CHECK(email LIKE '%@%.%'),
    data_inregistrare DATE DEFAULT SYSDATE
);

CREATE TABLE PLATFORMA
(
    cod_platforma NUMBER(3) constraint pkey_platforma PRIMARY KEY,
    nume VARCHAR2(30) constraint nume_platforma NOT NULL,
    data_lansare DATE,
    site VARCHAR2(50)
);

CREATE TABLE CONT
(
    cod_cont NUMBER(3) constraint pkey_cont PRIMARY KEY,
    cod_platforma NUMBER(3) constraint fkey_cont_platforma REFERENCES PLATFORMA(cod_platforma),
    nume VARCHAR2(30) constraint nume_cont NOT NULL,
    parola VARCHAR2(30) constraint parola_cont NOT NULL
);

CREATE TABLE JOC_VIDEO
(
    cod_joc NUMBER(7) constraint pkey_joc_video PRIMARY KEY,
    nume VARCHAR2(50) constraint nume_joc_video NOT NULL,
    data_lansare DATE,
    durata NUMBER(5, 1),
    tip VARCHAR2(4) constraint tip_joc_video CHECK (tip IN ('baza', 'dlc'))
);

CREATE TABLE DLC
(
    cod_joc NUMBER(7) constraint pkey_dlc REFERENCES JOC_VIDEO(cod_joc),
    cod_joc_baza NUMBER(7) constraint fkey_joc_dlc REFERENCES JOC_VIDEO(cod_joc),
                           constraint dlc_valid CHECK (cod_joc != cod_joc_baza)
);

CREATE TABLE RECENZIE
(
    cod_utilizator NUMBER(7) constraint fkey_recenzie_cod_utilizator REFERENCES UTILIZATOR(cod_utilizator),
    cod_joc NUMBER(7) constraint fkey_recenzie_cod_joc REFERENCES JOC_VIDEO(cod_joc),
    continut VARCHAR2(2000),
    scor NUMBER(1) constraint scor_valid CHECK(scor BETWEEN 1 AND 5),
    data_postare DATE DEFAULT SYSDATE,
    constraint pkey_recenzie PRIMARY KEY(cod_utilizator, cod_joc)
);

CREATE TABLE COMENTARIU
(
    cod_comentariu NUMBER(9) constraint pkey_comentariu PRIMARY KEY,
    cod_utilizator_recenzie NUMBER(7),
    cod_joc NUMBER(7),
    cod_utilizator NUMBER(7) constraint fkey_comentariu_cod_utilizator REFERENCES UTILIZATOR(cod_utilizator),
    continut VARCHAR2(1000) constraint continut_comentariu NOT NULL,
    data_postare DATE DEFAULT SYSDATE,
    constraint fkey_comentariu_recenzie FOREIGN KEY(cod_utilizator_recenzie, cod_joc) REFERENCES RECENZIE(cod_utilizator, cod_joc)
);

CREATE TABLE CATEGORIE
(
    cod_categorie NUMBER(3) constraint pkey_categorie PRIMARY KEY,
    nume VARCHAR2(30) constraint nume_categorie NOT NULL
);

CREATE TABLE DEZVOLTATOR
(
    cod_dezvoltator NUMBER(5) constraint pkey_dezvoltator PRIMARY KEY,
    nume VARCHAR2(30) constraint nume_dezvoltator NOT NULL,
    site VARCHAR2(50),
    data_infiintare DATE
);

CREATE TABLE EDITOR
(
    cod_editor NUMBER(5) constraint pkey_editor PRIMARY KEY,
    nume VARCHAR2(30) constraint nume_editor NOT NULL,
    site VARCHAR2(50),
    data_infiintare DATE
);

CREATE TABLE UTILIZATOR_UTILIZATOR
(
    cod_utilizator NUMBER(7) constraint fkey_urmarire_utilizator1 REFERENCES UTILIZATOR(cod_utilizator),
    cod_utilizator_urmarit NUMBER(7) constraint fkey_urmarire_utilizator2 REFERENCES UTILIZATOR(cod_utilizator),
                                     constraint urmarire_valid CHECK(cod_utilizator != cod_utilizator_urmarit),
    constraint pkey_urmarire PRIMARY KEY(cod_utilizator, cod_utilizator_urmarit)
);

CREATE TABLE JOC_VIDEO_CATEGORIE
(
    cod_joc NUMBER(7) constraint fkey_continut_joc REFERENCES JOC_VIDEO(cod_joc),
    cod_categorie NUMBER(3) constraint fkey_continut_categorie REFERENCES CATEGORIE(cod_categorie),
    constraint pkey_continut PRIMARY KEY(cod_joc, cod_categorie)
);

CREATE TABLE UTILIZATOR_JOC_VIDEO_CONT
(
    cod_utilizator NUMBER(7) constraint fkey_detine_utilizator REFERENCES UTILIZATOR(cod_utilizator),
    cod_joc NUMBER(7) constraint fkey_detine_joc REFERENCES JOC_VIDEO(cod_joc),
    cod_cont NUMBER(3) constraint fkey_detine_cont REFERENCES CONT(cod_cont),
    pret NUMBER(5, 2) constraint pret_joc NOT NULL,
    constraint pkey_detine PRIMARY KEY(cod_utilizator, cod_joc, cod_cont)
);

CREATE TABLE DEZVOLTATOR_EDITOR_JOC_VIDEO
(
    cod_dezvoltator NUMBER(5) constraint fkey_publica_dezvoltator REFERENCES DEZVOLTATOR(cod_dezvoltator),
    cod_editor NUMBER(5) constraint fkey_publica_editor REFERENCES EDITOR(cod_editor),
    cod_joc NUMBER(7) constraint fkey_publica_joc REFERENCES JOC_VIDEO(cod_joc),
    constraint pkey_publica PRIMARY KEY(cod_dezvoltator, cod_editor, cod_joc)
);

-- DROP TABLE
/*
DROP TABLE UTILIZATOR_UTILIZATOR;
DROP TABLE JOC_VIDEO_CATEGORIE;
DROP TABLE UTILIZATOR_JOC_VIDEO_CONT;
DROP TABLE DEZVOLTATOR_EDITOR_JOC_VIDEO;
DROP TABLE DLC;
DROP TABLE COMENTARIU;
DROP TABLE RECENZIE;
DROP TABLE UTILIZATOR;
DROP TABLE CONT;
DROP TABLE PLATFORMA;
DROP TABLE JOC_VIDEO;
DROP TABLE CATEGORIE;
DROP TABLE DEZVOLTATOR;
DROP TABLE EDITOR;
*/



-- Exercitiul 5
-- CREATE SEQUENCE
CREATE SEQUENCE secv_utilizator
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999
NOCYCLE;

CREATE SEQUENCE secv_platforma
INCREMENT BY 1
START WITH 1
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE secv_cont
INCREMENT BY 1
START WITH 1
MAXVALUE 9999
NOCYCLE;

CREATE SEQUENCE secv_joc_video
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999
NOCYCLE;

CREATE SEQUENCE secv_comentariu
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999
NOCYCLE;

CREATE SEQUENCE secv_categorie
INCREMENT BY 1
START WITH 1
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE secv_dezvoltator
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCYCLE;

CREATE SEQUENCE secv_editor
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCYCLE;

-- DROP SEQUENCE
/*
DROP SEQUENCE secv_utilizator;
DROP SEQUENCE secv_platforma;
DROP SEQUENCE secv_cont;
DROP SEQUENCE secv_joc_video;
DROP SEQUENCE secv_comentariu;
DROP SEQUENCE secv_categorie;
DROP SEQUENCE secv_dezvoltator;
DROP SEQUENCE secv_editor;
*/

-- INSERT
-- UTILIZATOR
INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email, data_inregistrare)
VALUES (secv_utilizator.NEXTVAL, 'Neculae', 'Andrei', 'parola123', 'andrei.fabian188@gmail.com', '01-JAN-2020');

INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Buzatu', 'Giulian', '321alorap', 'buzatu.giulian@gmail.com');

INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Ilie', 'Dumitru', 'parola321', 'ilie.dumitru12@yahoo.com');

INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email, data_inregistrare)
VALUES (secv_utilizator.NEXTVAL, 'Popescu', 'Stefan', '123alorap', 'stefan-popescu@s.unibuc.ro', '05-OCT-2021');

INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Grigore', 'Vlad', '1234567', 'vlad.grigore7@yahoo.com');


-- PLATFORMA
INSERT INTO PLATFORMA
VALUES (secv_platforma.NEXTVAL, 'Steam', '12-SEP-2003', 'https://store.steampowered.com/');

INSERT INTO PLATFORMA
VALUES (secv_platforma.NEXTVAL, 'Epic Games', '04-DEC-2018', 'https://www.epicgames.com/store/en-US/');

INSERT INTO PLATFORMA
VALUES (secv_platforma.NEXTVAL, 'Xbox', '01-AUG-2019', 'https://www.xbox.com/en-US/');

INSERT INTO PLATFORMA
VALUES (secv_platforma.NEXTVAL, 'Battle.net', '31-DEC-1996', 'https://us.shop.battle.net/en-us');

INSERT INTO PLATFORMA
VALUES (secv_platforma.NEXTVAL, 'Origin', '03-JUN-2011', 'https://www.origin.com/');

-- CONT
INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 1, 'n_andrei13', 'Andrei13');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 2, 'andrei137', 'Andrei13');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 5, 'Andrei_13', 'fabian125');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 1, 'b_giulian', 'buzatu7');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 4, 'BuzGiu', 'Giulian_17');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 2, 'the_winner', 'sunt_mitica');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 3, 'The_Winner', 'winner62');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 1, 'vlad_grigore', 'gri123');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 3, 'G_Vlad', 'gri123');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 1, 'pop_stef', 'stefan97');

INSERT INTO CONT
VALUES (secv_cont.NEXTVAL, 4, 'Horhe', 'Stefan_2342');


-- JOC_VIDEO
INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Life is Strange 2', '27-SEP-2018', '16', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Dead Space Remake', '27-JAN-2023', '11', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Alan Wake', '14-MAY-2010', '11', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Alan Wake The Signal', '12-OCT-2010', '1.5', 'dlc');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Alan Wake The Writer', '12-NOV-2010', '1.5', 'dlc');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Assassin''s Creed Syndicate', '23-OCT-2015', '18.5', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Assassin''s Creed Syndicate Jack the Ripper', '15-DEC-2015', '3', 'dlc');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Assassin''s Creed Syndicate The Last Maharaja', '01-MAR-2016', '2.5', 'dlc');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Assassin''s Creed Syndicate The Dreadful Crimes', '11-APR-2016', '3.5', 'dlc');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Tell Me Why', '17-AUG-2020', '9.5', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'World of Warcraft', '23-NOV-2004', '250', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Need For Speed Unbound', '29-NOV-2022', '23.5', 'baza');

INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Pronty', '19-NOV-2021', '7.5', 'baza');


-- DLC
INSERT INTO DLC
VALUES (4, 3);

INSERT INTO DLC
VALUES (5, 3);

INSERT INTO DLC
VALUES (7, 6);

INSERT INTO DLC
VALUES (8, 6);

INSERT INTO DLC
VALUES (9, 6);


-- RECENZIE
INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor)
VALUES (1, 2, 'Bun jocul, dar nu e pentru mine.', 3);

INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor, data_postare)
VALUES (4, 3, 'Mi-a placut foarte mult, recomand!', 5, '09-JAN-2023');

INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor)
VALUES (3, 6, 'Acest joc este o dezamagire, nu va pierdeti timpul si banii pe el', 1);

INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor)
VALUES (2, 10, 'Am pierdut prea mult timp in acest joc, mi-am facut foarte multi nervi, 10/10 recomand', 5);

INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor, data_postare)
VALUES (3, 13, 'Jocul este foarte bun, dar este doar pentru persoanele mai rafinate', 4, '01-JUN-2023');

INSERT INTO RECENZIE(cod_utilizator, cod_joc, continut, scor, data_postare)
VALUES (1, 13, 'Un joc excelent, abia astept sa se lanseze un dlc', 5, '17-AUG-2020');


-- COMENTARIU
INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 1, 2, 2, 'Si mie mi s-a parut bun jocul, 100% il recomand mai departe');

INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 1, 2, 3, 'Nu inteleg de ce nu ti-a placut, mie mi s-a parut un joc foarte bun');

INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 4, 3, 3, 'Personal nu am gasit ceva care sa ma atraga la acest joc, mi s-a parut prea plictisitor');

INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 3, 6, 1, 'Mie nu mi s-a parut o dezamagire, ba din contra, il consider un joc foarte bun, desi inteleg de ce ar putea dezamagi unele persoane'); 

INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 2, 10, 5, 'Si eu am pierdut foarte mult timp in acest joc, nu am simtit efectiv cum trec orele! Foarte buna treaba din partea developerilor!');

INSERT INTO COMENTARIU(cod_comentariu, cod_utilizator_recenzie, cod_joc, cod_utilizator, continut)
VALUES (secv_comentariu.NEXTVAL, 3, 13, 2, 'Nu ma consider o persoana ''rafinata'' si totusi nu mi s-a parut ca jocul ar fi prea slab, dar clar nu este de nota 10');


-- CATEGORIE
INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Actiune');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Aventura');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Science-fiction');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Horror');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Thriller');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Drama');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'MMORPG');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Curse');

INSERT INTO CATEGORIE
VALUES (secv_categorie.NEXTVAL, 'Metroidvania');


-- DEZVOLTATOR
INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'DONTNOD Entertainment', 'https://dont-nod.com/en/', '01-MAY-2008');

INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'Motive', 'https://www.ea.com/ea-studios/motive', '13-JULY-2015');

INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'Remedy Entertainment', 'https://www.remedygames.com/', '18-AUG-1995');

INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'Ubisoft Quebec', 'https://quebec.ubisoft.com/en/', '27-JUN-2005');

INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'Blizzard Entertainment', 'https://www.blizzard.com/en-us/', '08-FEB-1991');

INSERT INTO DEZVOLTATOR
VALUES (secv_dezvoltator.NEXTVAL, 'Criterion Games', 'https://www.ea.com/ea-studios/criterion-games', '01-JAN-1996');

INSERT INTO DEZVOLTATOR(cod_dezvoltator, nume, site)
VALUES (secv_dezvoltator.NEXTVAL, '18Light Game', 'https://18light.cc/en/');

INSERT INTO DEZVOLTATOR(cod_dezvoltator, nume)
VALUES (secv_dezvoltator.NEXTVAL, 'FunZone Games');


-- EDITOR
INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Square Enix', 'https://square-enix-games.com/en_US/home', '01-APR-2003');

INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Electronic Arts', 'https://www.ea.com/', '27-MAY-1982');

INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Remedy Entertainment', 'https://www.remedygames.com/', '18-AUG-1995');

INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Ubisoft', 'https://www.ubisoft.com/en-us/', '28-MAR-1986');

INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Xbox Game Studios', 'https://www.xbox.com/en-US/xbox-game-studios', '21-MAR-2000');

INSERT INTO EDITOR
VALUES (secv_editor.NEXTVAL, 'Blizzard Entertainment', 'https://www.blizzard.com/en-us/', '08-FEB-1991');

INSERT INTO EDITOR(cod_editor, nume, site)
VALUES (secv_editor.NEXTVAL, '18Light Game', 'https://18light.cc/en/');


-- UTILIZATOR_UTILIZATOR
INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (1, 2);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (1, 3);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (1, 5);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (2, 1);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (2, 3);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (2, 4);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (3, 1);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (3, 2);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (3, 5);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (4, 2);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (5, 1);

INSERT INTO UTILIZATOR_UTILIZATOR
VALUES (5, 4);


-- JOC_VIDEO_CATEGORIE
-- Adaugam categoriile manual la jocurile de baza
INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (1, 2);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (1, 6);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (2, 1);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (2, 2);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (2, 3);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (2, 4);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (3, 1);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (3, 2);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (3, 5);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (3, 6);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (6, 1);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (6, 2);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (10, 2);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (10, 6);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (11, 7);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (12, 8);

INSERT INTO JOC_VIDEO_CATEGORIE
VALUES (13, 9);

-- Adaugam aceleasi categorii de la jocul de baza la dlc folosind o cerere
INSERT INTO JOC_VIDEO_CATEGORIE
(
    SELECT d.cod_joc, jvc.cod_categorie
    FROM JOC_VIDEO jv
    JOIN DLC d ON (d.cod_joc_baza = jv.cod_joc)
    JOIN JOC_VIDEO_CATEGORIE jvc ON (d.cod_joc_baza = jvc.cod_joc)
);


-- UTILIZATOR_JOC_VIDEO_CONT
INSERT INTO UTILIZATOR_JOC_VIDEO_CONT
VALUES (2, 1, 4, '29.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (5, 2, 8, '19.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (4, 3, 10, '59.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (4, 4, 11, '0');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 6, 2, '24.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 7, 2, '5.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 8, 2, '5.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 9, 2, '5.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (3, 6, 7, '19.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 10, 2, '114.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 12, 1, '39.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 13, 1, '9.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (3, 13, 7, '14.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (5, 10, 9, '0');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (2, 10, 5, '129.99');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (4, 11, 11, '0');

INSERT INTO UTILIZATOR_JOC_VIDEO_CONT 
VALUES (1, 2, 3, '24.99');


-- DEZVOLTATOR_EDITOR_JOC_VIDEO
-- Adaugam dezvoltatori si editori manual la jocurile de baza
INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (1, 1, 1);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (2, 2, 2);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (3, 3, 3);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (4, 4, 6);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (1, 5, 10);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (5, 6, 11);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (6, 2, 12);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (7, 7, 13);

INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
VALUES (8, 7, 13);

-- Adaugam aceiasi dezvoltatori si aceiasi editori de la jocul de baza la dlc folosind o cerere
INSERT INTO DEZVOLTATOR_EDITOR_JOC_VIDEO
(
    SELECT dejv.cod_dezvoltator, dejv.cod_editor, d.cod_joc
    FROM JOC_VIDEO jv
    JOIN DLC d ON (d.cod_joc_baza = jv.cod_joc)
    JOIN DEZVOLTATOR_EDITOR_JOC_VIDEO dejv ON (d.cod_joc_baza = dejv.cod_joc)
);

-- DELETE VALUES
/*
DELETE FROM UTILIZATOR_UTILIZATOR;
DELETE FROM JOC_VIDEO_CATEGORIE;
DELETE FROM UTILIZATOR_JOC_VIDEO_CONT;
DELETE FROM DEZVOLTATOR_EDITOR_JOC_VIDEO;
DELETE FROM DLC;
DELETE FROM COMENTARIU;
DELETE FROM RECENZIE;
DELETE FROM UTILIZATOR;
DELETE FROM CONT;
DELETE FROM PLATFORMA;
DELETE FROM JOC_VIDEO;
DELETE FROM CATEGORIE;
DELETE FROM DEZVOLTATOR;
DELETE FROM EDITOR;
*/



-- Exercitiul 6
-- Implementare
CREATE OR REPLACE PROCEDURE info
(
    v_nume utilizator.nume%TYPE DEFAULT 'Neculae'
)
IS
    TYPE pair IS RECORD
    (
        platform platforma.nume%TYPE,
        username cont.nume%TYPE
    );
    TYPE vector IS VARRAY(3) OF pair;
    TYPE tablou_indexat IS TABLE OF joc_video.nume%TYPE INDEX BY PLS_INTEGER;
    TYPE tablou_imbricat IS TABLE OF recenzie.continut%TYPE;

    v_accounts vector := vector();
    v_games tablou_indexat;
    v_reviews tablou_imbricat := tablou_imbricat();
    v_nr_utilizator NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nr_utilizator
    FROM utilizator
    WHERE INITCAP(utilizator.nume) = INITCAP(v_nume);

    IF v_nr_utilizator = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista utilizator cu numele ' || v_nume);
        RETURN;
    END IF;

    IF v_nr_utilizator > 1 THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi utilizatori cu numele ' || v_nume);
        RETURN;
    END IF;

    SELECT DISTINCT p.nume, c.nume
    BULK COLLECT INTO v_accounts
    FROM cont c
    JOIN utilizator_joc_video_cont ujvc ON c.cod_cont = ujvc.cod_cont
    JOIN platforma p ON c.cod_platforma = p.cod_platforma
    JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
    WHERE INITCAP(u.nume) = INITCAP(v_nume) AND INITCAP(p.nume) IN ('Steam', 'Epic Games', 'Xbox');

    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    IF v_accounts.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista conturi asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Conturi asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR i IN 1..v_accounts.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(v_accounts(i).platform || ': ' || v_accounts(i).username);
        END LOOP;
    END IF;

    SELECT jv.nume
    BULK COLLECT INTO v_games
    FROM joc_video jv
    JOIN utilizator_joc_video_cont ujvc ON jv.cod_joc = ujvc.cod_joc
    JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
    WHERE INITCAP(u.nume) = INITCAP(v_nume);

    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    IF v_games.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista jocuri asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Jocuri asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR i IN 1..v_games.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(v_games(i));
        END LOOP;
    END IF;
    
    SELECT r.continut
    BULK COLLECT INTO v_reviews
    FROM recenzie r
    JOIN utilizator u ON r.cod_utilizator = u.cod_utilizator
    WHERE INITCAP(u.nume) = INITCAP(v_nume);

    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    IF v_reviews.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista recenzii asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Recenzii asociate utilizatorului ' || v_nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR i IN 1..v_reviews.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(v_reviews(i));
        END LOOP;
    END IF;
END;

-- Exemple
BEGIN
    info()
END;
/
BEGIN
    info('Buzatu')
END;
/
BEGIN
    info('Catalin');
END;
/
INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Neculae', 'Fabian', 'parola321', 'andrei.fabian188@gmail.com');
/
BEGIN
    info('Neculae');
END;
/
ROLLBACK;



-- Exercitiul 7
-- Implementare
CREATE OR REPLACE PROCEDURE games
(
    v_cerere NUMBER DEFAULT 1,
    v_init1 VARCHAR2 DEFAULT 'A', 
    v_init2 VARCHAR2 DEFAULT 'M'
)
IS 
    TYPE cursor_dinamic IS REF CURSOR RETURN categorie%ROWTYPE;
    categ cursor_dinamic;
    CURSOR jocuri(v_categ categorie.cod_categorie%TYPE) IS 
        SELECT jv.nume, data_lansare
        FROM joc_video jv
        JOIN joc_video_categorie jvc ON jv.cod_joc = jvc.cod_joc
        JOIN categorie c ON jvc.cod_categorie = c.cod_categorie
        WHERE c.cod_categorie = v_categ
        ORDER BY data_lansare;
    c categorie%ROWTYPE;
    j_nume joc_video.nume%TYPE;
    j_data joc_video.data_lansare%TYPE;
BEGIN
    IF v_cerere = 1 THEN
        OPEN categ FOR SELECT *
                       FROM categorie
                       WHERE INITCAP(nume) LIKE INITCAP(v_init1) || '%' OR INITCAP(nume) LIKE INITCAP(v_init2) || '%';

    ELSIF v_cerere = 2 THEN
        OPEN categ FOR SELECT *
                       FROM categorie
                       ORDER BY nume;

    ELSIF v_cerere = 3 THEN
        OPEN categ FOR SELECT *
                       FROM categorie
                       WHERE INITCAP(nume) LIKE INITCAP(v_init1) || '%' OR INITCAP(nume) LIKE INITCAP(v_init2) || '%'
                       ORDER BY nume DESC;

    END IF;
    LOOP
        FETCH categ INTO c;
        EXIT WHEN categ%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Categorie: ' || c.nume);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        OPEN jocuri(c.cod_categorie);
        LOOP
            FETCH jocuri INTO j_nume, j_data;
            EXIT WHEN jocuri%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(j_nume || ' lansat pe data de ' || j_data);
        END LOOP;
        IF jocuri%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista jocuri in aceasta categorie');
        END IF;
        CLOSE jocuri;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
    CLOSE categ;
END;

-- Exemple
BEGIN
    games();
END;
/
BEGIN
    games(2);
END;
/
BEGIN
    games(3, 'h', 't');
END;



-- Exercitiul 8
-- Implementare
CREATE OR REPLACE FUNCTION get_review_mark
(
    v_nume utilizator.nume%TYPE DEFAULT 'Grigore',
    v_joc joc_video.nume%TYPE DEFAULT 'Pronty'
) RETURN recenzie.scor%TYPE
IS
    v_scor NUMBER;
    v_nr_utilizator NUMBER;
    v_nr_joc NUMBER;
    v_nr_recenzie NUMBER;

    exception_no_user EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_no_user, -20001);

    exception_multiple_users EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_multiple_users, -20002);

    exception_no_game EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_no_game, -20003);

    exception_multiple_games EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_multiple_games, -20004);

    exception_no_review EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_no_review, -20005);
BEGIN
    SELECT COUNT(*)
    INTO v_nr_utilizator
    FROM utilizator
    WHERE INITCAP(utilizator.nume) = INITCAP(v_nume);

    IF v_nr_utilizator = 0 THEN
        RAISE exception_no_user;
    END IF;

    IF v_nr_utilizator > 1 then
        RAISE exception_multiple_users;
    END IF;

    SELECT COUNT(*)
    INTO v_nr_joc
    FROM joc_video
    WHERE INITCAP(joc_video.nume) = INITCAP(v_joc);

    IF v_nr_joc = 0 THEN
        RAISE exception_no_game;
    END IF;

    IF v_nr_joc > 1 then
        RAISE exception_multiple_games;
    END IF;

    SELECT COUNT(*)
    INTO v_nr_recenzie
    FROM recenzie
    JOIN utilizator ON utilizator.cod_utilizator = recenzie.cod_utilizator
    JOIN joc_video ON joc_video.cod_joc = recenzie.cod_joc
    WHERE INITCAP(utilizator.nume) = INITCAP(v_nume) AND INITCAP(joc_video.nume) = INITCAP(v_joc);

    IF v_nr_recenzie = 0 THEN
        RAISE exception_no_review;
    END IF;

    SELECT scor
    INTO v_scor
    FROM recenzie
    JOIN utilizator ON utilizator.cod_utilizator = recenzie.cod_utilizator
    JOIN joc_video ON joc_video.cod_joc = recenzie.cod_joc
    WHERE INITCAP(utilizator.nume) = INITCAP(v_nume) AND INITCAP(joc_video.nume) = INITCAP(v_joc);

    RETURN v_scor;
EXCEPTION
    WHEN exception_no_user THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu exista utilizator cu numele ' || v_nume);
    WHEN exception_multiple_users THEN
        RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi utilizatori cu numele ' || v_nume);
    WHEN exception_no_game THEN
        RAISE_APPLICATION_ERROR(-20003, 'Nu exista joc cu numele ' || v_joc);
    WHEN exception_multiple_games THEN
        RAISE_APPLICATION_ERROR(-20004, 'Exista mai multe jocuri cu numele ' || v_joc);
    WHEN exception_no_review THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nu exista recenzie pentru jocul ' || v_joc || ' de catre utilizatorul ' || v_nume);
END;

-- Exemple
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark('Neculae', 'Dead Space Remake') || '/5');
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark() || '/5');
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark('Fabian') || '/5');
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark('Neculae', 'GTA V') || '/5');
END;
/
INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Neculae', 'Fabian', 'parola321', 'andrei.fabian188@gmail.com');
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark('Neculae', 'Dead Space Remake') || '/5');
END;
/
ROLLBACK;
/
INSERT INTO JOC_VIDEO
VALUES (secv_joc_video.NEXTVAL, 'Life is Strange 2', '27-SEP-2023', '16', 'dlc');
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scor: ' || get_review_mark('Buzatu', 'Life is Strange 2') || '/5');
END;
/
ROLLBACK;



-- Exercitiul 9
-- Implementare
CREATE OR REPLACE PROCEDURE find_user
(
    v_dezvoltator dezvoltator.nume%TYPE DEFAULT 'FunZone Games'
)
IS
    v_nr_dezvoltator NUMBER;
    v_max NUMBER;
    v_utilizator VARCHAR2(128);

    exception_no_developer EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_no_developer, -20001);

    exception_multiple_developers EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_multiple_developers, -20002);
BEGIN
    SELECT COUNT(*)
    INTO v_nr_dezvoltator
    FROM dezvoltator
    WHERE INITCAP(dezvoltator.nume) = INITCAP(v_dezvoltator);

    IF v_nr_dezvoltator = 0 THEN
        RAISE exception_no_developer;
    END IF;

    IF v_nr_dezvoltator > 1 THEN
        RAISE exception_multiple_developers;
    END IF;

    SELECT MAX(nr_jocuri)
    INTO v_max
    FROM
    (
        SELECT COUNT(*) AS nr_jocuri
        FROM joc_video jv
        JOIN dezvoltator_editor_joc_video dejv ON jv.cod_joc = dejv.cod_joc
        JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
        WHERE INITCAP(d.nume) = INITCAP(v_dezvoltator)
        GROUP BY d.nume
    );

    SELECT nume || ' ' || prenume
    INTO v_utilizator
    FROM
    (
        SELECT u.nume, u.prenume, COUNT(*) AS nr_jocuri
        FROM joc_video jv
        JOIN dezvoltator_editor_joc_video dejv ON jv.cod_joc = dejv.cod_joc
        JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
        JOIN utilizator_joc_video_cont ujvc ON jv.cod_joc = ujvc.cod_joc
        JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(d.nume) = INITCAP(v_dezvoltator)
        GROUP BY u.nume, u.prenume
        HAVING COUNT(*) = v_max
    );

    DBMS_OUTPUT.PUT_LINE('Utilizatorul care detine cele mai multe jocuri de la dezvoltatorul ' || v_dezvoltator || ' este ' || v_utilizator);
EXCEPTION
    WHEN exception_no_developer THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu exista dezvoltator cu numele ' || v_dezvoltator);
    WHEN exception_multiple_developers THEN
        RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi dezvoltatori cu numele ' || v_dezvoltator);
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Nu exista utilizator care detine jocuri de la dezvoltatorul ' || v_dezvoltator);
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Exista mai multi utilizatori care detin numarul maxim de jocuri de la dezvoltatorul ' || v_dezvoltator);
END;

-- Exemple
BEGIN
    find_user('Ubisoft Quebec');
END;
/
BEGIN
    find_user();
END;
/
BEGIN
    find_user('Ubisoft Romania');
END;
/
INSERT INTO DEZVOLTATOR(cod_dezvoltator, nume)
VALUES (secv_dezvoltator.NEXTVAL, 'FunZone Games');
/
BEGIN
    find_user();
END;
/
ROLLBACK;
/
INSERT INTO DEZVOLTATOR(cod_dezvoltator, nume)
VALUES (secv_dezvoltator.NEXTVAL, 'FromSoftware');
/
BEGIN
    find_user('FromSoftware');
END;
/
ROLLBACK;



-- Exercitiul 10
-- Implementare
CREATE OR REPLACE TRIGGER trigger_control
    BEFORE INSERT OR UPDATE OR DELETE ON UTILIZATOR
BEGIN
    IF TO_CHAR(SYSDATE, 'DD') MOD 2 = 1 AND TO_CHAR(SYSDATE, 'MM') MOD 2 = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu se poate modifica tabela in zilele impare ale lunilor pare');
    ELSIF TO_CHAR(SYSDATE, 'DD') MOD 2 = 0 AND TO_CHAR(SYSDATE, 'MM') MOD 2 = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu se poate modifica tabela in zilele pare ale lunilor impare');
    END IF;
END;

-- Exemple
SELECT SYSDATE FROM DUAL;
/
INSERT INTO UTILIZATOR(cod_utilizator, nume, prenume, parola, email)
VALUES (secv_utilizator.NEXTVAL, 'Toader', 'Catalin', 'catatoa', 'cata.toader@gmail.com');
/
ROLLBACK;



-- Exercitiul 11
-- Implementare
CREATE OR REPLACE TRIGGER delete_game_trigger
    FOR DELETE ON joc_video
COMPOUND TRIGGER
    TYPE tablou_imbricat IS TABLE OF joc_video.cod_joc%TYPE;
    game_ids tablou_imbricat := tablou_imbricat();
    v_exista NUMBER;

    BEFORE EACH ROW IS
    BEGIN
        DELETE FROM comentariu
        WHERE cod_joc = :OLD.cod_joc;
    
        DELETE FROM recenzie
        WHERE cod_joc = :OLD.cod_joc;

        DELETE FROM utilizator_joc_video_cont
        WHERE cod_joc = :OLD.cod_joc;

        DELETE FROM dezvoltator_editor_joc_video
        WHERE cod_joc = :OLD.cod_joc;

        DELETE FROM joc_video_categorie
        WHERE cod_joc = :OLD.cod_joc;

        SELECT cod_joc
        BULK COLLECT INTO game_ids
        FROM dlc
        WHERE cod_joc_baza = :OLD.cod_joc;

        FOR I IN 1..game_ids.COUNT LOOP
            DELETE FROM comentariu
            WHERE cod_joc = game_ids(I);
            
            DELETE FROM recenzie
            WHERE cod_joc = game_ids(I);

            DELETE FROM utilizator_joc_video_cont
            WHERE cod_joc = game_ids(I);

            DELETE FROM dezvoltator_editor_joc_video
            WHERE cod_joc = game_ids(I);

            DELETE FROM joc_video_categorie
            WHERE cod_joc = game_ids(I);

            DELETE FROM dlc
            WHERE cod_joc = game_ids(I);
        END LOOP;
    END BEFORE EACH ROW;

    AFTER STATEMENT IS
    BEGIN
        SELECT cod_joc
        BULK COLLECT INTO game_ids
        FROM joc_video
        WHERE tip = 'dlc';

        FOR I IN 1..game_ids.COUNT LOOP
            SELECT COUNT(*)
            INTO v_exista
            FROM dlc
            WHERE cod_joc = game_ids(I);

            IF v_exista = 0 THEN
                DELETE FROM comentariu
                WHERE cod_joc = game_ids(I);
            
                DELETE FROM recenzie
                WHERE cod_joc = game_ids(I);

                DELETE FROM utilizator_joc_video_cont
                WHERE cod_joc = game_ids(I);

                DELETE FROM dezvoltator_editor_joc_video
                WHERE cod_joc = game_ids(I);

                DELETE FROM joc_video_categorie
                WHERE cod_joc = game_ids(I);

                DELETE FROM joc_video
                WHERE cod_joc = game_ids(I);
            END IF;
        END LOOP;
    END AFTER STATEMENT;
END delete_game_trigger;

-- Exemple
DELETE FROM joc_video
WHERE INITCAP(nume) = INITCAP('Assassin''s Creed Syndicate');
/
SELECT * FROM joc_video;
SELECT * FROM dlc;
SELECT * FROM recenzie;
SELECT * FROM comentariu;
SELECT * FROM utilizator_joc_video_cont;
SELECT * FROM dezvoltator_editor_joc_video;
SELECT * FROM joc_video_categorie;
/
ROLLBACK;



-- Exercitiul 12
-- Implementare
CREATE SEQUENCE secv_log
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCYCLE;
/
CREATE TABLE LOGS
(
    cod_log NUMBER(5) constraint pkey_log PRIMARY KEY,
    message VARCHAR2(128),
    timestamp DATE
);
/
CREATE OR REPLACE TRIGGER log_trigger
    BEFORE ALTER OR DROP OR CREATE ON SCHEMA
DECLARE
    v_message VARCHAR2(128);
BEGIN
    v_message := 'Table ' || ora_dict_obj_name || ' was ' || ora_sysevent;
    IF (ora_sysevent = 'ALTER') THEN
        v_message := v_message || 'ED';
    ELSIF (ora_sysevent = 'DROP') THEN
        v_message := v_message || 'PED';
    ELSE
        v_message := v_message || 'D';
    END IF;
    INSERT INTO logs 
    VALUES (secv_log.NEXTVAL, v_message, SYSDATE);
END;

-- Exemple
CREATE TABLE TEST
(
    cod NUMBER
);
/
ALTER TABLE TEST ADD (denumire VARCHAR2(128));
/
DROP TABLE TEST;
/
SELECT message, TO_CHAR(timestamp, 'DD-MON-YYYY HH24:MI:SS') AS timestamp 
FROM logs;
/
DROP TRIGGER log_trigger;
/
DROP TABLE logs;
/
DROP SEQUENCE secv_log;



-- Exercitiul 13
-- Implementare
CREATE OR REPLACE PACKAGE package_13 AS
    PROCEDURE info(v_nume utilizator.nume%TYPE DEFAULT 'Neculae');
    PROCEDURE games(v_init1 VARCHAR2 DEFAULT 'A', v_init2 VARCHAR2 DEFAULT 'M');
    FUNCTION get_review_mark(v_nume utilizator.nume%TYPE DEFAULT 'Grigore', v_joc joc_video.nume%TYPE DEFAULT 'Pronty') RETURN recenzie.scor%TYPE;
    PROCEDURE find_user(v_dezvoltator dezvoltator.nume%TYPE DEFAULT 'FunZone Games');
END package_13;
/
CREATE OR REPLACE PACKAGE BODY package_13 AS
    PROCEDURE info
    (
        v_nume utilizator.nume%TYPE DEFAULT 'Neculae'
    )
    IS
        TYPE pair IS RECORD
        (
            platform platforma.nume%TYPE,
            username cont.nume%TYPE
        );
        TYPE vector IS VARRAY(3) OF pair;
        TYPE tablou_indexat IS TABLE OF joc_video.nume%TYPE INDEX BY PLS_INTEGER;
        TYPE tablou_imbricat IS TABLE OF recenzie.continut%TYPE;

        v_accounts vector := vector();
        v_games tablou_indexat;
        v_reviews tablou_imbricat := tablou_imbricat();
        v_exista NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_exista
        FROM utilizator
        WHERE INITCAP(utilizator.nume) = INITCAP(v_nume);

        IF v_exista = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista utilizator cu numele ' || v_nume);
            RETURN;
        END IF;
        
        IF v_exista > 1 THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi utilizatori cu numele ' || v_nume);
            RETURN;
        END IF;

        SELECT DISTINCT p.nume, c.nume
        BULK COLLECT INTO v_accounts
        FROM cont c
        JOIN utilizator_joc_video_cont ujvc ON c.cod_cont = ujvc.cod_cont
        JOIN platforma p ON c.cod_platforma = p.cod_platforma
        JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(u.nume) = INITCAP(v_nume) AND INITCAP(p.nume) IN ('Steam', 'Epic Games', 'Xbox');

        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        IF v_accounts.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista conturi asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Conturi asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            FOR i IN 1..v_accounts.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(v_accounts(i).platform || ': ' || v_accounts(i).username);
            END LOOP;
        END IF;

        SELECT jv.nume
        BULK COLLECT INTO v_games
        FROM joc_video jv
        JOIN utilizator_joc_video_cont ujvc ON jv.cod_joc = ujvc.cod_joc
        JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(u.nume) = INITCAP(v_nume);

        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        IF v_games.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista jocuri asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Jocuri asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            FOR i IN 1..v_games.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(v_games(i));
            END LOOP;
        END IF;
        
        SELECT r.continut
        BULK COLLECT INTO v_reviews
        FROM recenzie r
        JOIN utilizator u ON r.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(u.nume) = INITCAP(v_nume);

        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        IF v_reviews.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista recenzii asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Recenzii asociate utilizatorului ' || v_nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            FOR i IN 1..v_reviews.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(v_reviews(i));
            END LOOP;
        END IF;
    END;

    PROCEDURE games
    (
        v_init1 VARCHAR2 DEFAULT 'A', 
        v_init2 VARCHAR2 DEFAULT 'M'
    )
    IS 
        TYPE tip_cursor IS REF CURSOR RETURN categorie%ROWTYPE;
        categ tip_cursor;
        CURSOR jocuri(v_categ categorie.cod_categorie%TYPE) IS 
            SELECT jv.nume, data_lansare
            FROM joc_video jv
            JOIN joc_video_categorie jvc ON jv.cod_joc = jvc.cod_joc
            JOIN categorie c ON jvc.cod_categorie = c.cod_categorie
            WHERE c.cod_categorie = v_categ
            ORDER BY data_lansare;
        c categorie%ROWTYPE;
        j_nume joc_video.nume%TYPE;
        j_data joc_video.data_lansare%TYPE;
    BEGIN
        OPEN categ FOR
            SELECT *
            FROM categorie
            WHERE INITCAP(nume) LIKE INITCAP(v_init1) || '%' OR INITCAP(nume) LIKE INITCAP(v_init2) || '%';
        LOOP
            FETCH categ INTO c;
            EXIT WHEN categ%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE('Categorie: ' || c.nume);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            OPEN jocuri(c.cod_categorie);
            LOOP
                FETCH jocuri INTO j_nume, j_data;
                EXIT WHEN jocuri%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(j_nume || ' lansat pe data de ' || j_data);
            END LOOP;
            IF jocuri%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Nu exista jocuri in aceasta categorie');
            END IF;
            CLOSE jocuri;
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        CLOSE categ;
    END;

    FUNCTION get_review_mark
    (
        v_nume utilizator.nume%TYPE DEFAULT 'Grigore', 
        v_joc joc_video.nume%TYPE DEFAULT 'Pronty'
    ) RETURN recenzie.scor%TYPE
    IS
        v_scor NUMBER;
        v_exista_utilizator NUMBER;
        v_exista_joc NUMBER;
        v_exista_recenzie NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_exista_utilizator
        FROM utilizator
        WHERE INITCAP(utilizator.nume) = INITCAP(v_nume);

        IF v_exista_utilizator = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista utilizator cu numele ' || v_nume);
        END IF;

        IF v_exista_utilizator > 1 then
            RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi utilizatori cu numele ' || v_nume);
        END IF;

        SELECT COUNT(*)
        INTO v_exista_joc
        FROM joc_video
        WHERE INITCAP(joc_video.nume) = INITCAP(v_joc);

        IF v_exista_joc = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Nu exista joc cu numele ' || v_joc);
        END IF;

        IF v_exista_joc > 1 then
            RAISE_APPLICATION_ERROR(-20004, 'Exista mai multe jocuri cu numele ' || v_joc);
        END IF;

        SELECT COUNT(*)
        INTO v_exista_recenzie
        FROM recenzie
        JOIN utilizator ON utilizator.cod_utilizator = recenzie.cod_utilizator
        JOIN joc_video ON joc_video.cod_joc = recenzie.cod_joc
        WHERE INITCAP(utilizator.nume) = INITCAP(v_nume) AND INITCAP(joc_video.nume) = INITCAP(v_joc);

        IF v_exista_recenzie = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Nu exista recenzie pentru jocul ' || v_joc || ' de catre utilizatorul ' || v_nume);
        END IF;

        SELECT scor
        INTO v_scor
        FROM recenzie
        JOIN utilizator ON utilizator.cod_utilizator = recenzie.cod_utilizator
        JOIN joc_video ON joc_video.cod_joc = recenzie.cod_joc
        WHERE INITCAP(utilizator.nume) = INITCAP(v_nume) AND INITCAP(joc_video.nume) = INITCAP(v_joc);

        RETURN v_scor;
    END;

    PROCEDURE find_user
    (
        v_dezvoltator dezvoltator.nume%TYPE DEFAULT 'FunZone Games'
    )
    IS
        v_exista NUMBER;
        v_max NUMBER;
        v_utilizator VARCHAR2(128);
    BEGIN
        SELECT COUNT(*)
        INTO v_exista
        FROM dezvoltator
        WHERE INITCAP(dezvoltator.nume) = INITCAP(v_dezvoltator);

        IF v_exista = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista dezvoltator cu numele ' || v_dezvoltator);
        END IF;

        IF v_exista > 1 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi dezvoltator cu numele ' || v_dezvoltator);
        END IF;

        SELECT MAX(nr_jocuri)
        INTO v_max
        FROM
        (
            SELECT COUNT(*) AS nr_jocuri
            FROM joc_video jv
            JOIN dezvoltator_editor_joc_video dejv ON jv.cod_joc = dejv.cod_joc
            JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
            WHERE INITCAP(d.nume) = INITCAP(v_dezvoltator)
            GROUP BY d.nume
        );

        SELECT nume || ' ' || prenume
        INTO v_utilizator
        FROM
        (
            SELECT u.nume, u.prenume, COUNT(*) AS nr_jocuri
            FROM joc_video jv
            JOIN dezvoltator_editor_joc_video dejv ON jv.cod_joc = dejv.cod_joc
            JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
            JOIN utilizator_joc_video_cont ujvc ON jv.cod_joc = ujvc.cod_joc
            JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
            WHERE INITCAP(d.nume) = INITCAP(v_dezvoltator)
            GROUP BY u.nume, u.prenume
            HAVING COUNT(*) = v_max
        );

        DBMS_OUTPUT.PUT_LINE('Utilizatorul care detine cele mai multe jocuri de la dezvoltatorul ' || v_dezvoltator || ' este ' || v_utilizator);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista utilizator care detine jocuri de la dezvoltatorul ' || v_dezvoltator);
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi utilizatori care detin numarul maxim de jocuri de la dezvoltatorul ' || v_dezvoltator);
    END;
END package_13;



-- Exercitiul 14
-- Implementare
CREATE OR REPLACE TYPE tablou_imbricat_joc AS TABLE OF VARCHAR2(50);
/
CREATE TABLE info_utilizator
(
    nume VARCHAR2(30),
    prenume VARCHAR2(30),
    jocuri tablou_imbricat_joc
) NESTED TABLE jocuri STORE AS tablou_jocuri;
/
CREATE OR REPLACE PACKAGE package_14 AS
    TYPE tuplu_joc IS RECORD
    (
        nume_joc joc_video.nume%TYPE,
        tip_joc joc_video.tip%TYPE,
        nume_dezvoltator dezvoltator.nume%TYPE,
        nume_editor editor.nume%TYPE
    );
    TYPE tablou_indexat_joc IS TABLE OF tuplu_joc INDEX BY PLS_INTEGER;

    TYPE tuplu_info IS RECORD
    (
        username cont.nume%TYPE,
        parola cont.parola%TYPE,
        nume_platforma platforma.nume%TYPE
    );
    TYPE tablou_imbricat_info IS TABLE OF tuplu_info;
    TYPE info IS RECORD
    (
        nume utilizator.nume%TYPE,
        prenume utilizator.prenume%TYPE,
        conturi tablou_imbricat_info
    );

    PROCEDURE category_games_details(v_categorie categorie.nume%TYPE DEFAULT 'Drama');
    PROCEDURE insert_values(v_nume utilizator.nume%TYPE DEFAULT 'Neculae', v_prenume utilizator.prenume%TYPE DEFAULT 'Andrei');
    FUNCTION get_info(v_nume utilizator.nume%TYPE DEFAULT 'Neculae', v_cenzura NUMBER DEFAULT 1) RETURN info;
    FUNCTION nr_games(v_min NUMBER DEFAULT 1, v_dezvoltator dezvoltator.nume%TYPE DEFAULT 'DONTNOD Entertainment') RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY package_14 AS
    PROCEDURE category_games_details
    (
        v_categorie categorie.nume%TYPE DEFAULT 'Drama'
    )
    IS
        v_jocuri tablou_indexat_joc;
        v_scor_mediu NUMBER;
    BEGIN
        SELECT j.nume, INITCAP(j.tip), d.nume, e.nume
        BULK COLLECT INTO v_jocuri
        FROM joc_video j
        JOIN dezvoltator_editor_joc_video dejv ON j.cod_joc = dejv.cod_joc
        JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
        JOIN editor e ON dejv.cod_editor = e.cod_editor
        JOIN joc_video_categorie jvc ON j.cod_joc = jvc.cod_joc
        JOIN categorie c ON jvc.cod_categorie = c.cod_categorie
        WHERE INITCAP(c.nume) = INITCAP(v_categorie);

        FOR I IN 1..v_jocuri.COUNT LOOP
            SELECT AVG(scor)
            INTO v_scor_mediu
            FROM recenzie r
            JOIN joc_video j ON r.cod_joc = j.cod_joc
            WHERE j.nume = v_jocuri(i).nume_joc;

            DBMS_OUTPUT.PUT_LINE('Nume joc    : ' || v_jocuri(i).nume_joc || chr(10) || 
                                 'Tip joc     : ' || v_jocuri(i).tip_joc || chr(10) ||
                                 'Dezvoltator : ' || v_jocuri(i).nume_dezvoltator || chr(10) || 
                                 'Editor      : ' || v_jocuri(i).nume_editor);
            IF v_scor_mediu IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('Scor        : nu are recenzii' || chr(10));
            ELSE
                DBMS_OUTPUT.PUT_LINE('Scor        : ' || v_scor_mediu || '/5' || chr(10));
            END IF;
                                 
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista categorie cu numele ' || v_categorie);
    END;

    PROCEDURE insert_values
    (
        v_nume utilizator.nume%TYPE DEFAULT 'Neculae',
        v_prenume utilizator.prenume%TYPE DEFAULT 'Andrei'
    )
    IS
        v_jocuri tablou_imbricat_joc := tablou_imbricat_joc();
        v_exista NUMBER(1);
    BEGIN
        SELECT j.nume
        BULK COLLECT INTO v_jocuri
        FROM joc_video j
        JOIN utilizator_joc_video_cont ujvc ON j.cod_joc = ujvc.cod_joc
        JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(u.nume) = INITCAP(v_nume) AND INITCAP(u.prenume) = INITCAP(v_prenume);

        SELECT COUNT(*)
        INTO v_exista
        FROM info_utilizator
        WHERE nume = v_nume AND prenume = v_prenume;

        IF v_exista = 1 THEN
            UPDATE info_utilizator
            SET jocuri = v_jocuri
            WHERE nume = v_nume AND prenume = v_prenume;
        ELSE
            INSERT INTO info_utilizator
            VALUES (v_nume, v_prenume, v_jocuri);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista utilizator cu numele ' || v_nume || ' ' || v_prenume);
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi utilizatori cu numele ' || v_nume || ' ' || v_prenume);
    END;

    FUNCTION get_info
    (
        v_nume utilizator.nume%TYPE DEFAULT 'Neculae',
        v_cenzura NUMBER DEFAULT 1
    ) RETURN info 
    IS
        v_info info;
        v_conturi tablou_imbricat_info := tablou_imbricat_info();
    BEGIN
        SELECT u.nume, u.prenume
        INTO v_info.nume, v_info.prenume
        FROM utilizator u
        WHERE INITCAP(u.nume) = INITCAP(v_nume);

        SELECT DISTINCT c.nume, c.parola, p.nume
        BULK COLLECT INTO v_conturi
        FROM cont c
        JOIN utilizator_joc_video_cont ujvc ON c.cod_cont = ujvc.cod_cont
        JOIN platforma p ON c.cod_platforma = p.cod_platforma
        JOIN utilizator u ON ujvc.cod_utilizator = u.cod_utilizator
        WHERE INITCAP(u.nume) = INITCAP(v_nume);

        IF v_cenzura = 1 THEN
            FOR I IN 1..v_conturi.COUNT LOOP
                v_conturi(i).parola := RPAD('*', LENGTH(v_conturi(i).parola), '*');
            END LOOP;
        END IF;

        v_info.conturi := v_conturi;

        RETURN v_info;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista utilizator cu numele ' || v_nume);
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi utilizatori cu numele ' || v_nume);
    END;

    FUNCTION nr_games
    (
        v_min NUMBER DEFAULT 1,
        v_dezvoltator dezvoltator.nume%TYPE DEFAULT 'DONTNOD Entertainment'
    ) RETURN NUMBER
    IS
        CURSOR jocuri(v_dezvoltator dezvoltator.nume%TYPE) IS 
            SELECT j.cod_joc
            FROM joc_video j
            JOIN dezvoltator_editor_joc_video dejv ON j.cod_joc = dejv.cod_joc
            JOIN dezvoltator d ON dejv.cod_dezvoltator = d.cod_dezvoltator
            WHERE INITCAP(d.nume) = INITCAP(v_dezvoltator);
        j joc_video.cod_joc%TYPE;
        v_nr_utilizaor NUMBER := 0;
        v_nr_joc NUMBER := 0;
    BEGIN
        OPEN jocuri(v_dezvoltator);
        LOOP
            FETCH jocuri INTO j;
            EXIT WHEN jocuri%NOTFOUND;

            SELECT COUNT(*)
            INTO v_nr_utilizaor
            FROM utilizator_joc_video_cont ujvc
            JOIN joc_video j ON ujvc.cod_joc = j.cod_joc
            WHERE ujvc.cod_joc = j;

            IF v_nr_utilizaor >= v_min THEN
                v_nr_joc := v_nr_joc + 1;
            END IF;
        END LOOP;
        CLOSE jocuri;

        RETURN v_nr_joc;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nu exista dezvoltator cu numele ' || v_dezvoltator);
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi dezvoltatori cu numele ' || v_dezvoltator);
    END;
END;

-- Exemple
DECLARE
    informatii package_14.info := package_14.get_info();
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Conturile utilizatorului ' || informatii.nume || ' ' || informatii.prenume);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');

    FOR i IN 1..informatii.conturi.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Store   : ' || informatii.conturi(i).nume_platforma || chr(10) || 
                             'Username: ' || informatii.conturi(i).username || chr(10) || 
                             'Password: ' || informatii.conturi(i).parola || chr(10));
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/
DECLARE
    informatii package_14.info := package_14.get_info('Buzatu', 0);
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Conturile utilizatorului ' || informatii.nume || ' ' || informatii.prenume);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');

    FOR i IN 1..informatii.conturi.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Store   : ' || informatii.conturi(i).nume_platforma || chr(10) || 
                             'Username: ' || informatii.conturi(i).username || chr(10) || 
                             'Password: ' || informatii.conturi(i).parola || chr(10));
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/
DECLARE
    informatii package_14.info := package_14.get_info('Toader');
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Conturile utilizatorului ' || informatii.nume || ' ' || informatii.prenume);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');

    FOR i IN 1..informatii.conturi.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Store   : ' || informatii.conturi(i).nume_platforma || chr(10) || 
                             'Username: ' || informatii.conturi(i).username || chr(10) || 
                             'Password: ' || informatii.conturi(i).parola || chr(10));
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
/
INSERT INTO RECENZIE 
VALUES (1, 10, 'Recenzie de test', 2, SYSDATE);
/
BEGIN
    package_14.category_games_details();
END;
/
ROLLBACK;
/
BEGIN
    package_14.insert_values();
END;
/
BEGIN
    package_14.insert_values('Popescu', 'Stefan');
END;
/
SELECT nume, prenume, t.*
FROM info_utilizator iu, TABLE(iu.jocuri) t;
/
DECLARE
    v_min NUMBER := 1;
    v_dezvoltator dezvoltator.nume%TYPE := 'DONTNOD Entertainment';
BEGIN
    IF v_min = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Numarul de jocuri dezvoltate de ' || v_dezvoltator || 
                             ' detinute de cel putin ' || v_min || ' utilizator este ' || package_14.nr_games());
    ELSE
        DBMS_OUTPUT.PUT_LINE('Numarul de jocuri dezvoltate de ' || v_dezvoltator || 
                             ' detinute de cel putin ' || v_min || ' utilizatori este ' || package_14.nr_games(v_min, v_dezvoltator));
    END IF;
END;
/
DECLARE
    v_min NUMBER := 3;
    v_dezvoltator dezvoltator.nume%TYPE := 'DONTNOD Entertainment';
BEGIN
    IF v_min = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Numarul de jocuri dezvoltate de ' || v_dezvoltator || 
                             ' detinute de cel putin ' || v_min || ' utilizator este ' || package_14.nr_games());
    ELSE
        DBMS_OUTPUT.PUT_LINE('Numarul de jocuri dezvoltate de ' || v_dezvoltator || 
                             ' detinute de cel putin ' || v_min || ' utilizatori este ' || package_14.nr_games(v_min, v_dezvoltator));
    END IF;
END;