-- public.causalconcepts definition

-- Drop table

-- DROP TABLE public.causalconcepts;

CREATE TABLE public.causalconcepts (
	cui varchar(255) NULL,
	covname varchar(999) NULL,
	semtype varchar(50) NULL
);


-- public.causalpredications definition

-- Drop table

-- DROP TABLE public.causalpredications;

CREATE TABLE public.causalpredications (
	predication_id int4 NULL,
	sentence_id int4 NULL,
	pmid varchar(20) NULL,
	predicate varchar(50) NULL,
	subject_cui varchar(255) NULL,
	subject_name varchar(999) NULL,
	subject_semtype varchar(50) NULL,
	subject_novelty int4 NULL,
	object_cui varchar(255) NULL,
	object_name varchar(999) NULL,
	object_semtype varchar(50) NULL,
	object_novelty int4 NULL,
        fact_value varchar(20) NULL,
	mod_scale varchar(20) NULL,
	mod_value varchar(20) NULL
);


-- public.citations definition

-- Drop table

-- DROP TABLE public.citations;

CREATE TABLE public.citations (
	pmid varchar(20) NOT NULL,
	issn varchar(10) NULL DEFAULT NULL::character varying,
	dp varchar(50) NULL DEFAULT NULL::character varying,
	edat varchar(50) NULL DEFAULT NULL::character varying,
	pyear varchar(4) NULL,
	CONSTRAINT citations_pkey PRIMARY KEY (pmid)
);

-- public.generic_concept definition

-- Drop table

-- DROP TABLE public.generic_concept;

CREATE TABLE public.generic_concept (
	concept_id int4 NOT NULL,
	cui varchar(20) NOT NULL DEFAULT ''::character varying,
	preferred_name varchar(999) NOT NULL DEFAULT ''::character varying,
	CONSTRAINT generic_concept_pkey PRIMARY KEY (concept_id)
);

-- public.issns definition

-- Drop table

-- DROP TABLE public.issns;

CREATE TABLE public.issns (
	id int4 NOT NULL,
	journal_title varchar(999) NULL DEFAULT NULL::character varying,
	nlm_ta varchar(255) NULL DEFAULT NULL::character varying,
	pissn varchar(10) NULL DEFAULT NULL::character varying,
	eissn varchar(10) NULL DEFAULT NULL::character varying,
	publisher varchar(255) NOT NULL,
	locatorplus_id varchar(255) NOT NULL,
	latest_issue varchar(255) NULL DEFAULT NULL::character varying,
	earliest_volume varchar(255) NULL DEFAULT NULL::character varying,
	free_access varchar(255) NULL DEFAULT NULL::character varying,
	open_access varchar(255) NULL DEFAULT NULL::character varying,
	participation_level varchar(255) NULL DEFAULT NULL::character varying,
	deposit_status varchar(255) NULL DEFAULT NULL::character varying,
	journal_url varchar(255) NULL DEFAULT NULL::character varying
);

-- public.mrconso definition

-- Drop table

-- DROP TABLE public.mrconso;

CREATE TABLE public.mrconso (
	cui bpchar(100) NOT NULL,
	lat bpchar(3) NOT NULL,
	ts bpchar(1) NOT NULL,
	lui bpchar(100) NOT NULL,
	stt varchar(3) NOT NULL,
	sui bpchar(100) NOT NULL,
	ispref bpchar(10) NOT NULL,
	aui varchar(100) NOT NULL,
	saui varchar(100) NULL,
	scui varchar(100) NULL,
	sdui varchar(100) NULL,
	sab varchar(50) NOT NULL,
	tty varchar(50) NOT NULL,
	code varchar(100) NOT NULL,
	str text NOT NULL,
	srl bpchar(100) NOT NULL,
	suppress bpchar(1) NOT NULL,
	cvf int4 NULL,
	dummy bpchar(100) NULL,
	CONSTRAINT x_mrconso_pk PRIMARY KEY (aui)
);


-- public.sentence definition

-- Drop table

-- DROP TABLE public.sentence;

CREATE TABLE public.sentence (
	sentence_id int4 NOT NULL,
	pmid varchar(10) NOT NULL,
	"type" varchar(20) NOT NULL,
	"number" int4 NOT NULL DEFAULT 0,
	sent_start_index int4 NOT NULL DEFAULT 0,
	sentence varchar(999) NOT NULL,
	sent_end_index int4 NOT NULL DEFAULT 0,
	section_header varchar(100) NULL DEFAULT NULL::character varying,
	normalized_section_header varchar(50) NULL DEFAULT NULL::character varying,
	CONSTRAINT sentence_pkey PRIMARY KEY (sentence_id)
);

CREATE INDEX x_cp_object_cui ON public.causalpredications USING btree (object_cui);
CREATE INDEX x_cp_object_name ON public.causalpredications USING btree (object_name);
CREATE INDEX x_cp_object_semtype ON public.causalpredications USING btree (object_semtype);
CREATE INDEX x_cp_pmid ON public.causalpredications USING btree (pmid);
CREATE INDEX x_cp_predicate ON public.causalpredications USING btree (predicate);
CREATE INDEX x_cp_predication_id ON public.causalpredications USING btree (predication_id);
CREATE INDEX x_cp_sentence_id ON public.causalpredications USING btree (sentence_id);
CREATE INDEX x_cp_subject_cui ON public.causalpredications USING btree (subject_cui);
CREATE INDEX x_cp_subject_name ON public.causalpredications USING btree (subject_name);
CREATE INDEX x_cp_subject_semtype ON public.causalpredications USING btree (subject_semtype);

CREATE INDEX x_citations_issn ON public.citations USING btree (issn);
CREATE INDEX x_citations_pmid ON public.citations USING btree (pmid);
CREATE INDEX x_citations_pyear ON public.citations USING btree (pyear);

CREATE INDEX x_generic_concept_concept_id ON public.generic_concept USING btree (concept_id);
CREATE INDEX x_generic_concept_cui ON public.generic_concept USING btree (cui);
CREATE INDEX x_generic_concept_preferred_name ON public.generic_concept USING btree (preferred_name);

CREATE INDEX x_issns_journal_title ON public.issns USING btree (journal_title);
CREATE INDEX x_issns_pissn ON public.issns USING btree (pissn);

CREATE INDEX x_mrconso_code ON public.mrconso USING btree (code);
CREATE INDEX x_mrconso_cui ON public.mrconso USING btree (cui);
CREATE INDEX x_mrconso_lui ON public.mrconso USING btree (lui);
CREATE INDEX x_mrconso_sab_tty ON public.mrconso USING btree (sab, tty);
CREATE INDEX x_mrconso_scui ON public.mrconso USING btree (scui);
CREATE INDEX x_mrconso_str ON public.mrconso USING btree (str);
CREATE INDEX x_mrconso_sui ON public.mrconso USING btree (sui);

CREATE INDEX x_sentence_pmid ON public.sentence USING btree (pmid);
CREATE INDEX x_sentence_sentence ON public.sentence USING btree (sentence);
CREATE INDEX x_sentence_sentence_id ON public.sentence USING btree (sentence_id);
CREATE INDEX x_sentence_type ON public.sentence USING btree (type);

COPY causalConcepts 
FROM '/Users/scottalexandermalec/Projects/smdb/causalConcepts.csv'
DELIMITER E'\t'
CSV HEADER;

COPY causalPredications 
FROM '/Users/scottalexandermalec/Projects/smdb/semmedVER43_2022_R_PREDICATION.csv'
DELIMITER ','
CSV HEADER;

COPY citations 
FROM '/Users/scottalexandermalec/Projects/smdb/semmedVER43_2022_R_CITATIONS.csv'
DELIMITER ','
CSV HEADER;

COPY generic_concept 
FROM '/Users/scottalexandermalec/Projects/smdb/semmedVER43_2022_R_GENERIC_CONCEPT.csv'
DELIMITER ','
CSV HEADER;

COPY issns
FROM '/Users/scottalexandermalec/Projects/smdb/issns.csv'
DELIMITER E'\t'
CSV HEADER;

COPY mrconso 
FROM '/Users/scottalexandermalec/Projects/smdb/mrconso.csv'
DELIMITER E'\t'
CSV HEADER;

COPY variablecodes 
FROM '/Users/scottalexandermalec/Projects/smdb/variablecodes.csv'
DELIMITER E'\t'
CSV HEADER;


