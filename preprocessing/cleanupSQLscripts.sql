

sudo pgloader mysql://causalehr:mandarin@localhost/causalehr pgsql://causalehr:mandarin@localhost/causalehr
2023-12-19T20:45:14.016000Z LOG pgloader version "3.6.3~devel"
2023-12-19T20:45:14.020000Z LOG Data errors in '/tmp/pgloader/'
2023-12-19T20:45:14.068000Z LOG Migrating from #<MYSQL-CONNECTION mysql://causalehr@localhost:3306/causalehr {1007339A43}>
2023-12-19T20:45:14.068000Z LOG Migrating into #<PGSQL-CONNECTION pgsql://causalehr@localhost:5432/causalehr {10076148D3}>

2023-12-20T00:57:15.157024Z ERROR PostgreSQL Database error 42830: there is no unique constraint matching given keys for referenced table "sentence"
QUERY: ALTER TABLE causalehr.predication ADD CONSTRAINT predication_ibfk_2 FOREIGN KEY(pmid) REFERENCES causalehr.sentence(pmid) ON UPDATE CASCADE ON DELETE CASCADE
2023-12-20T00:59:48.383700Z LOG report summary reset
               table name     errors       rows      bytes      total time
-------------------------  ---------  ---------  ---------  --------------
          fetch meta data          0         26                     0.116s
           Create Schemas          0          0                     0.000s
         Create SQL Types          0          0                     0.004s
            Create tables          0         12                     0.028s
           Set Table OIDs          0          6                     0.004s
-------------------------  ---------  ---------  ---------  --------------
         causalehr.entity          0  1887317669   137.7 GB    2h34m25.030s
    causalehr.predication          0  126268045    13.0 GB       30m0.246s
       causalehr.sentence          0  253029872    43.2 GB       59m8.827s
      causalehr.citations          0   36151516     1.4 GB       4m43.238s
causalehr.predication_aux          0  126268040    13.1 GB      17m35.115s
causalehr.generic_concept          0        259     7.6 kB          0.196s
-------------------------  ---------  ---------  ---------  --------------
  COPY Threads Completion          0          4                3h51m8.168s
           Create Indexes          0         15               2h38m35.722s
   Index Build Completion          0         15                  2m23.591s
          Reset Sequences          0          5                     0.044s
             Primary Keys          0          6                     0.004s
      Create Foreign Keys          1          4                  21m2.157s
          Create Triggers          0          2                     0.004s
         Install Comments          0         23                     0.004s
-------------------------  ---------  ---------  ---------  --------------
        Total import time          ✓  2429035401   208.4 GB     6h53m9.691s

 sudo -i -u postgres
[sudo] password for user: 
Your RAID array seems to be healthy
postgres@lamassu:~$ \c postgres
c: command not found
postgres@lamassu:~$ psql 
psql (14.10 (Ubuntu 14.10-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# \c causalehr; 
You are now connected to database "causalehr" as user "postgres".
causalehr=# \dt
Did not find any relations.
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# select user;
   user   
----------
 postgres
(1 row)

causalehr=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT
causalehr=# commit; 
WARNING:  there is no transaction in progress
COMMIT
causalehr=# /dt
causalehr-# /l
causalehr-# /dt
causalehr-# select user;
ERROR:  syntax error at or near "/"
LINE 1: /dt
        ^
causalehr=# select user;
   user   
----------
 postgres
(1 row)

causalehr=# \l
causalehr=# \c causalehr; 
You are now connected to database "causalehr" as user "postgres".
causalehr=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA causalehr TO postgres;
GRANT
causalehr=# \dt
Did not find any relations.
causalehr=# \dt
Did not find any relations.
causalehr=# GRANT ALL PRIVILEGES ON SENTENCE; IN SCHEMA causalehr TO postgres;
ERROR:  syntax error at or near ";"
LINE 1: GRANT ALL PRIVILEGES ON SENTENCE;
                                        ^
ERROR:  syntax error at or near "IN"
LINE 1: IN SCHEMA causalehr TO postgres;
        ^
causalehr=# GRANT ALL PRIVILEGES ON SENTENCE TO postgres;
ERROR:  relation "sentence" does not exist
causalehr=# \c public
connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "public" does not exist
Previous connection kept
causalehr=# \dt
Did not find any relations.
causalehr=# \l
causalehr=# \l+
causalehr=# \c postgres
You are now connected to database "postgres" as user "postgres".
postgres=# \dt
Did not find any relations.
postgres=# \dt+
Did not find any relations.
postgres=# \l+
postgres=# \dt
Did not find any relations.
postgres=# \l
postgres=# \c causalehr; 
You are now connected to database "causalehr" as user "postgres".
causalehr=# \dt
Did not find any relations.
causalehr=# \dt causalehr
Did not find any relation named "causalehr".
causalehr=# \dt causalehr.*
                List of relations
  Schema   |      Name       | Type  |   Owner   
-----------+-----------------+-------+-----------
 causalehr | citations       | table | causalehr
 causalehr | entity          | table | causalehr
 causalehr | generic_concept | table | causalehr
 causalehr | predication     | table | causalehr
 causalehr | predication_aux | table | causalehr
 causalehr | sentence        | table | causalehr
(6 rows)

causalehr=# select * from causalehr.sentence limit 1000;
causalehr=# SET SEARCH_PATH = causalehr; 
SET
causalehr=# \dt
                List of relations
  Schema   |      Name       | Type  |   Owner   
-----------+-----------------+-------+-----------
 causalehr | citations       | table | causalehr
 causalehr | entity          | table | causalehr
 causalehr | generic_concept | table | causalehr
 causalehr | predication     | table | causalehr
 causalehr | predication_aux | table | causalehr
 causalehr | sentence        | table | causalehr
(6 rows)

causalehr=# ALTER DATABASE causalehr SET SEARCH_PATH TO causalehr; 
ALTER DATABASE
causalehr=# \q
postgres@lamassu:~$ psql 
psql (14.10 (Ubuntu 14.10-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# \c causalehr
You are now connected to database "causalehr" as user "postgres".
causalehr=# \dt
                List of relations
  Schema   |      Name       | Type  |   Owner   
-----------+-----------------+-------+-----------
 causalehr | citations       | table | causalehr
 causalehr | entity          | table | causalehr
 causalehr | generic_concept | table | causalehr
 causalehr | predication     | table | causalehr
 causalehr | predication_aux | table | causalehr
 causalehr | sentence        | table | causalehr
(6 rows)

causalehr=# CREATE TABLE causalpredication AS SELECT * FROM predication; 

SELECT 126268045
causalehr=# 
causalehr=# select count(distinct pmid) from causalpredication; 
  count   
----------
 23182541
(1 row)

causalehr=# drop table causalpredication; 
DROP TABLE
causalehr=# commit ;
WARNING:  there is no transaction in progress
COMMIT
causalehr=# CREATE TABLE causalpred AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_WITH", "COMPLICATES", "MANIFESTATION_OF", "PREVENTS", "PRODUCES", "TREATS", "INTERACTS_WITH", "STIMULATES", "INHIBITS", "CAUSES", "PREDISPOSES", "ASSOCIATED_WITH", "DISRUPTS", "AUGMENTS", "AFFECTS", "PRECEDES") AND object_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr") AND subject_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr");
ERROR:  column "COEXISTS_WITH" does not exist
LINE 1: ... AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_...
                                                             ^
causalehr=# CREATE TABLE causalpred AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_WITH", "COMPLICATES", "MANIFESTATION_OF", "PREVENTS", "PRODUCES", "TREATS", "INTERACTS_WITH", "STIMULATES", "INHIBITS", "CAUSES", "PREDISPOSES", "ASSOCIATED_WITH", "DISRUPTS", "AUGMENTS", "AFFECTS", "PRECEDES") AND object_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr") AND subject_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr");
ERROR:  column "COEXISTS_WITH" does not exist
LINE 1: ... AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_...
                                                             ^
causalehr=# CREATE TABLE causalpred AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_WITH", "COMPLICATES", "MANIFESTATION_OF", "PREVENTS", "PRODUCES", "TREATS", "INTERACTS_WITH", "STIMULATES", "INHIBITS", "CAUSES", "PREDISPOSES", "ASSOCIATED_WITH", "DISRUPTS", "AUGMENTS", "AFFECTS", "PRECEDES") AND object_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr") AND subject_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr");
ERROR:  column "COEXISTS_WITH" does not exist
LINE 1: ... AS SELECT * FROM predication WHERE predicate IN ("COEXISTS_...
                                                             ^
causalehr=# CREATE TABLE causalpred AS SELECT * FROM predication WHERE predicate IN ('COEXISTS_WITH', "COMPLICATES", "MANIFESTATION_OF", "PREVENTS", "PRODUCES", "TREATS", "INTERACTS_WITH", "STIMULATES", "INHIBITS", "CAUSES", "PREDISPOSES", "ASSOCIATED_WITH", "DISRUPTS", "AUGMENTS", "AFFECTS", "PRECEDES") AND object_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr") AND subject_semtype NOT IN ("acty", "bhvr", "evnt", "gora", "mcha", "ocac", "clas", "cnce", "ftcn", "grpa", "idcn", "inpr", "lang", "qlco", "rnlw", "spco", "tmco", "enty", "mnob", "phob", "bmod", "ocdi", "hcro", "orgt", "pros", "shro", "eehu", "hcpp", "npop", "phpr");
ERROR:  column "COMPLICATES" does not exist
LINE 1: ... predication WHERE predicate IN ('COEXISTS_WITH', "COMPLICAT...
                                                             ^
causalehr=# \dt predication
              List of relations
  Schema   |    Name     | Type  |   Owner   
-----------+-------------+-------+-----------
 causalehr | predication | table | causalehr
(1 row)

causalehr=# \d predication
causalehr=# select distinct subject_semtype from predication limit 100;

causalehr=# CREATE TABLE causalpred AS SELECT * FROM predication WHERE predicate IN ('COEXISTS_WITH', 'COMPLICATES', 'MANIFESTATION_OF', 'PREVENTS', 'PRODUCES', 'TREATS', 'INTERACTS_WITH', 'STIMULATES', 'INHIBITS', 'CAUSES', 'PREDISPOSES', 'ASSOCIATED_WITH', 'DISRUPTS', 'AUGMENTS', 'AFFECTS', 'PRECEDES') AND object_semtype NOT IN ('acty', 'bhvr', 'evnt', 'gora', 'mcha', 'ocac', 'clas', 'cnce', 'ftcn', 'grpa', 'idcn', 'inpr', 'lang', 'qlco', 'rnlw', 'spco', 'tmco', 'enty', 'mnob', 'phob', 'bmod', 'ocdi', 'hcro', 'orgt', 'pros', 'shro', 'eehu', 'hcpp', 'npop', 'phpr') AND subject_semtype NOT IN ('acty', 'bhvr', 'evnt', 'gora', 'mcha', 'ocac', 'clas', 'cnce', 'ftcn', 'grpa', 'idcn', 'inpr', 'lang', 'qlco', 'rnlw', 'spco', 'tmco', 'enty', 'mnob', 'phob', 'bmod', 'ocdi', 'hcro', 'orgt', 'pros', 'shro', 'eehu', 'hcpp', 'npop', 'phpr');
SELECT 43784371
causalehr=# select count(distinct pmid) from causalpred; 
  count   
----------
 14352343
(1 row)

causalehr=# \d predication
causalehr=# \d predication_aux
causalehr=# CREATE TABLE causalpred_aux AS SELECT * FROM predication_aux WHERE predication_id IN (select predication_id from causalpred); 
SELECT 43784370
causalehr=# select COUNT(*) from predication_aux; 
   count   
-----------
 126268040
(1 row)

causalehr=# \d+ sentence
causalehr=# \dt+ predication
causalehr=# \d sentence
causalehr=# \d predication
causalehr=# CREATE TABLE causalsentence AS SELECT * FROM sentence WHERE sentence_id IN (select sentence_id from causalpred); 

SELECT 32139886
causalehr=# 
causalehr=# \d predication
causalehr=# CREATE TABLE causalcitations AS SELECT * FROM citations WHERE pmid IN (select pmid from causalpred); 
SELECT 14352343
causalehr=# \dt
                List of relations
  Schema   |      Name       | Type  |   Owner   
-----------+-----------------+-------+-----------
 causalehr | causalcitations | table | postgres
 causalehr | causalpred      | table | postgres
 causalehr | causalpred_aux  | table | postgres
 causalehr | causalsentence  | table | postgres
 causalehr | citations       | table | causalehr
 causalehr | entity          | table | causalehr
 causalehr | generic_concept | table | causalehr
 causalehr | predication     | table | causalehr
 causalehr | predication_aux | table | causalehr
 causalehr | sentence        | table | causalehr
(10 rows)

causalehr=# \dt+
causalehr=# \d entity
                                        Table "causalehr.entity"
   Column    |          Type          | Collation | Nullable |                  Default                  
-------------+------------------------+-----------+----------+-------------------------------------------
 entity_id   | bigint                 |           | not null | nextval('entity_entity_id_seq'::regclass)
 sentence_id | bigint                 |           | not null | 
 pmid        | character varying(20)  |           | not null | ''::character varying
 cui         | character varying(255) |           |          | NULL::character varying
 name        | character varying(999) |           |          | NULL::character varying
 semtype     | character varying(50)  |           |          | NULL::character varying
 gene_id     | character varying(999) |           | not null | ''::character varying
 gene_name   | character varying(999) |           | not null | ''::character varying
 text        | character varying(999) |           |          | ''::character varying
 score       | bigint                 |           |          | '0'::bigint
 start_index | bigint                 |           |          | '0'::bigint
 end_index   | bigint                 |           |          | '0'::bigint
Indexes:
    "idx_16403_primary" PRIMARY KEY, btree (entity_id)
    "idx_16403_pmid_entity_index_btree" btree (pmid)
    "idx_16403_sentence_id" btree (sentence_id)
Foreign-key constraints:
    "entity_ibfk_1" FOREIGN KEY (sentence_id) REFERENCES sentence(sentence_id) ON UPDATE CASCADE ON DELETE CASCADE

causalehr=# select * from entity limit 10; 
causalehr=# \d predication; 
                                             Table "causalehr.predication"
     Column      |          Type          | Collation | Nullable |                       Default                       
-----------------+------------------------+-----------+----------+-----------------------------------------------------
 predication_id  | bigint                 |           | not null | nextval('predication_predication_id_seq'::regclass)
 sentence_id     | bigint                 |           | not null | 
 pmid            | character varying(20)  |           |          | NULL::character varying
 predicate       | character varying(50)  |           |          | NULL::character varying
 subject_cui     | character varying(255) |           |          | NULL::character varying
 subject_name    | character varying(999) |           |          | NULL::character varying
 subject_semtype | character varying(50)  |           |          | NULL::character varying
 subject_novelty | boolean                |           |          | 
 object_cui      | character varying(255) |           |          | NULL::character varying
 object_name     | character varying(999) |           |          | NULL::character varying
 object_semtype  | character varying(50)  |           |          | NULL::character varying
 object_novelty  | boolean                |           |          | 
 fact_value      | character(20)          |           |          | NULL::bpchar
 mod_scale       | character(20)          |           |          | NULL::bpchar
 mod_value       | double precision       |           |          | 
Indexes:
    "idx_16427_primary" PRIMARY KEY, btree (predication_id)
    "idx_16427_pmid_index_btree" btree (pmid)
    "idx_16427_sentence_id" btree (sentence_id)
Foreign-key constraints:
    "predication_ibfk_1" FOREIGN KEY (sentence_id) REFERENCES sentence(sentence_id) ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "predication_aux" CONSTRAINT "predication_aux_ibfk_1" FOREIGN KEY (predication_id) REFERENCES predication(predication_id) ON UPDATE CASCADE ON DELETE CASCADE

causalehr=# CREATE TABLE causalentity AS SELECT * FROM entity WHERE pmid IN (select pmid from causalpred) AND sentence_id IN (select sentence_id from causalpred); 





SELECT 219096719
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# 
causalehr=# \dt+
                                                            List of relations
  Schema   |      Name       | Type  |   Owner   | Persistence | Access method |  Size   |                  Description                   
-----------+-----------------+-------+-----------+-------------+---------------+---------+------------------------------------------------
 causalehr | causalcitations | table | postgres  | permanent   | heap          | 1071 MB | 
 causalehr | causalentity    | table | postgres  | permanent   | heap          | 25 GB   | 
 causalehr | causalpred      | table | postgres  | permanent   | heap          | 5842 MB | 
 causalehr | causalpred_aux  | table | postgres  | permanent   | heap          | 7987 MB | 
 causalehr | causalsentence  | table | postgres  | permanent   | heap          | 8320 MB | 
 causalehr | citations       | table | causalehr | permanent   | heap          | 2689 MB | 
 causalehr | entity          | table | causalehr | permanent   | heap          | 208 GB  | Stores semantic predications in sentences
 causalehr | generic_concept | table | causalehr | permanent   | heap          | 48 kB   | Stores basic UMLS concept information
 causalehr | predication     | table | causalehr | permanent   | heap          | 16 GB   | Stores aggregate info of semantic predications
 causalehr | predication_aux | table | causalehr | permanent   | heap          | 22 GB   | Stores semantic predications in sentences
 causalehr | sentence        | table | causalehr | permanent   | heap          | 57 GB   | Stores sentences from Medline
(11 rows)

causalehr=# \dt generic_concept; 
                List of relations
  Schema   |      Name       | Type  |   Owner   
-----------+-----------------+-------+-----------
 causalehr | generic_concept | table | causalehr
(1 row)

causalehr=# \dt+ generic_concept
                                                       List of relations
  Schema   |      Name       | Type  |   Owner   | Persistence | Access method | Size  |              Description              
-----------+-----------------+-------+-----------+-------------+---------------+-------+---------------------------------------
 causalehr | generic_concept | table | causalehr | permanent   | heap          | 48 kB | Stores basic UMLS concept information
(1 row)

causalehr=# \d generic_concept
                                          Table "causalehr.generic_concept"
     Column     |          Type          | Collation | Nullable |                       Default                       
----------------+------------------------+-----------+----------+-----------------------------------------------------
 concept_id     | bigint                 |           | not null | nextval('generic_concept_concept_id_seq'::regclass)
 cui            | character varying(20)  |           | not null | ''::character varying
 preferred_name | character varying(200) |           | not null | ''::character varying
Indexes:
    "idx_16420_primary" PRIMARY KEY, btree (concept_id)
    "idx_16420_preferred_name" btree (preferred_name)

causalehr=# select * from predication where subject_cui IN (select cui from generic_concept) limit 100;
causalehr=# CREATE TABLE causalpredication AS SELECT * FROM causalpred WHERE subject_cui NOT IN (select cui from generic_concept) OR object_cui NOT IN (select cui from generic_concept); 
SELECT 43192062
causalehr=# \dt+
                                                             List of relations
  Schema   |       Name        | Type  |   Owner   | Persistence | Access method |  Size   |                  Description                   
-----------+-------------------+-------+-----------+-------------+---------------+---------+------------------------------------------------
 causalehr | causalcitations   | table | postgres  | permanent   | heap          | 1071 MB | 
 causalehr | causalentity      | table | postgres  | permanent   | heap          | 25 GB   | 
 causalehr | causalpred        | table | postgres  | permanent   | heap          | 5842 MB | 
 causalehr | causalpred_aux    | table | postgres  | permanent   | heap          | 7987 MB | 
 causalehr | causalpredication | table | postgres  | permanent   | heap          | 5766 MB | 
 causalehr | causalsentence    | table | postgres  | permanent   | heap          | 8320 MB | 
 causalehr | citations         | table | causalehr | permanent   | heap          | 2689 MB | 
 causalehr | entity            | table | causalehr | permanent   | heap          | 208 GB  | Stores semantic predications in sentences
 causalehr | generic_concept   | table | causalehr | permanent   | heap          | 48 kB   | Stores basic UMLS concept information
 causalehr | predication       | table | causalehr | permanent   | heap          | 16 GB   | Stores aggregate info of semantic predications
 causalehr | predication_aux   | table | causalehr | permanent   | heap          | 22 GB   | Stores semantic predications in sentences
 causalehr | sentence          | table | causalehr | permanent   | heap          | 57 GB   | Stores sentences from Medline
(12 rows)

causalehr=# select * from causal_predication limit 10;
ERROR:  relation "causal_predication" does not exist
LINE 1: select * from causal_predication limit 10;
                      ^
causalehr=# select * from causalpredication limit 10;
 predication_id | sentence_id |   pmid   |   predicate    | subject_cui |                    subject_name                    | subject_semtype | subject_novelty | object_cui |           object_name           | object_semtype | object_novelty | fact_value | mod_scale | mod_value 
----------------+-------------+----------+----------------+-------------+----------------------------------------------------+-----------------+-----------------+------------+---------------------------------+----------------+----------------+------------+-----------+-----------
      193386357 |   366954540 | 33899956 | PREVENTS       | C0030899    | pentoxifylline                                     | orch            | t               | C0014544   | Epilepsy                        | dsyn           | t              |            |           |          
      193386359 |   366954541 | 33899956 | AFFECTS        | C1290882    | Chronic nervous system disorder                    | dsyn            | t               | C0678908   | brain function                  | ortf           | t              |            |           |          
      193386361 |   366954542 | 33899956 | INTERACTS_WITH | C0028589    | Nuclear Proteins                                   | gngm            | t               | C0007634   | Cells                           | cell           | f              |            |           |          
      193386365 |   366954550 | 33899956 | INHIBITS       | C0030899    | pentoxifylline                                     | orch            | t               | C2986635   | Programmed Cell Death Protein 1 | gngm           | t              |            |           |          
      193386366 |   366954551 | 33899956 | DISRUPTS       | C0013227    | Pharmaceutical Preparations                        | phsu            | f               | C0014544   | Epilepsy                        | dsyn           | t              |            |           |          
      193386367 |   366954553 | 33899957 | TREATS         | C1148475    | Complementary and alternative medicine             | topp            | t               | C0019944   | Equus caballus                  | mamm           | t              |            |           |          
      193386377 |   366954601 | 33899960 | TREATS         | C1705576    | Allogeneic Hematopoietic Stem Cell Transplantation | topp            | t               | C0376545   | Hematologic Neoplasms           | neop           | t              |            |           |          
      193386379 |   366954604 | 33899960 | PREVENTS       | C0302189    | Cell Therapy                                       | topp            | t               | C0012634   | Disease                         | dsyn           | f              |            |           |          
      193386385 |   366954617 | 33899962 | AUGMENTS       | C0017853    | Hemoglobin, Glycosylated                           | aapp            | t               | C2585282   | Blood glucose concentration     | fndg           | t              |            |           |          
      193386386 |   366954619 | 33899962 | TREATS         | C0935563    | Piercing procedure                                 | topp            | t               | C1292123   | Hematopoietic system finding    | fndg           | t              |            |           |          
(10 rows)

causalehr=# select * from causalpred limit 10;
 predication_id | sentence_id |   pmid   |   predicate    | subject_cui |                    subject_name                    | subject_semtype | subject_novelty | object_cui |           object_name           | object_semtype | object_novelty | fact_value | mod_scale | mod_value 
----------------+-------------+----------+----------------+-------------+----------------------------------------------------+-----------------+-----------------+------------+---------------------------------+----------------+----------------+------------+-----------+-----------
      193386357 |   366954540 | 33899956 | PREVENTS       | C0030899    | pentoxifylline                                     | orch            | t               | C0014544   | Epilepsy                        | dsyn           | t              |            |           |          
      193386359 |   366954541 | 33899956 | AFFECTS        | C1290882    | Chronic nervous system disorder                    | dsyn            | t               | C0678908   | brain function                  | ortf           | t              |            |           |          
      193386361 |   366954542 | 33899956 | INTERACTS_WITH | C0028589    | Nuclear Proteins                                   | gngm            | t               | C0007634   | Cells                           | cell           | f              |            |           |          
      193386365 |   366954550 | 33899956 | INHIBITS       | C0030899    | pentoxifylline                                     | orch            | t               | C2986635   | Programmed Cell Death Protein 1 | gngm           | t              |            |           |          
      193386366 |   366954551 | 33899956 | DISRUPTS       | C0013227    | Pharmaceutical Preparations                        | phsu            | f               | C0014544   | Epilepsy                        | dsyn           | t              |            |           |          
      193386367 |   366954553 | 33899957 | TREATS         | C1148475    | Complementary and alternative medicine             | topp            | t               | C0019944   | Equus caballus                  | mamm           | t              |            |           |          
      193386377 |   366954601 | 33899960 | TREATS         | C1705576    | Allogeneic Hematopoietic Stem Cell Transplantation | topp            | t               | C0376545   | Hematologic Neoplasms           | neop           | t              |            |           |          
      193386379 |   366954604 | 33899960 | PREVENTS       | C0302189    | Cell Therapy                                       | topp            | t               | C0012634   | Disease                         | dsyn           | f              |            |           |          
      193386385 |   366954617 | 33899962 | AUGMENTS       | C0017853    | Hemoglobin, Glycosylated                           | aapp            | t               | C2585282   | Blood glucose concentration     | fndg           | t              |            |           |          
      193386386 |   366954619 | 33899962 | TREATS         | C0935563    | Piercing procedure                                 | topp            | t               | C1292123   | Hematopoietic system finding    | fndg           | t              |            |           |          
(10 rows)

causalehr=# select count(pmid) from causalpred; 
  count   
----------
 43784371
(1 row)

causalehr=# select count(pmid) from causalpredication; 
  count   
----------
 43192062
(1 row)





