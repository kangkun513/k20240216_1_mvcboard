CREATE TABLE "MVCBOARD" (
    "IDX" NUMBER(*,0) NOT NULL, 
	"NAME" VARCHAR2(20 BYTE) NOT NULL, 
	"SUBJECT" VARCHAR2(200 BYTE) NOT NULL, 
	"CONTENT" VARCHAR2(3000 BYTE) NOT NULL, 
	"GUP" NUMBER(*,0), 
	"LEV" NUMBER(*,0), 
	"SEQ" NUMBER(*,0), 
	"HIT" NUMBER(*,0) DEFAULT 0, 
	"WRITEDATE" TIMESTAMP (6) DEFAULT sysdate, 
	 CONSTRAINT "MVCBOARD_PK" PRIMARY KEY ("IDX")
);

DELETE FROM mvcboard;
DROP SEQUENCE mvcboard_idx_seq;
CREATE SEQUENCE mvcboard_idx_seq;
commit;

INSERT INTO mvcboard (idx, name, subject, content, gup, lev, seq)
VALUES (mvcboard_idx_seq.nextval, 'Dummy1', 'Dummy1', 'Dummy1', mvcboard_idx_seq.currval, 0, 0);
INSERT INTO mvcboard (idx, name, subject, content, gup, lev, seq)
VALUES (mvcboard_idx_seq.nextval, 'Dummy2', 'Dummy2', 'Dummy2', mvcboard_idx_seq.currval, 0, 0);
INSERT INTO mvcboard (idx, name, subject, content, gup, lev, seq)
VALUES (mvcboard_idx_seq.nextval, 'Dummy3', 'Dummy3', 'Dummy3', mvcboard_idx_seq.currval, 0, 0);
INSERT INTO mvcboard (idx, name, subject, content, gup, lev, seq)
VALUES (mvcboard_idx_seq.nextval, 'Dummy4', 'Dummy4', 'Dummy4', mvcboard_idx_seq.currval, 0, 0);
commit;

SELECT * FROM mvcboard order by gup desc, seq asc;
SELECT COUNT(*) FROM mvcboard;


