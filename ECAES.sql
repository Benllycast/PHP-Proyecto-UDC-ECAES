--
-- PostgreSQL database dump
--

-- Started on 2009-12-03 20:31:22

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 3230 (class 1262 OID 16393)
-- Dependencies: 3229
-- Name: ECAES; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "ECAES" IS 'Base de datos del proyecto';


--
-- TOC entry 1229 (class 2612 OID 16396)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

--CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 1062 (class 1247 OID 16399)
-- Dependencies: 6 2777
-- Name: breakpoint; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE breakpoint AS (
	func oid,
	linenumber integer,
	targetname text
);


ALTER TYPE public.breakpoint OWNER TO postgres;

--
-- TOC entry 1065 (class 0 OID 0)
-- Name: chkpass; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass;


--
-- TOC entry 20 (class 1255 OID 16401)
-- Dependencies: 6 1065
-- Name: chkpass_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_in(cstring) RETURNS chkpass
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_in';


ALTER FUNCTION public.chkpass_in(cstring) OWNER TO postgres;

--
-- TOC entry 21 (class 1255 OID 16402)
-- Dependencies: 6 1065
-- Name: chkpass_out(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_out(chkpass) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_out';


ALTER FUNCTION public.chkpass_out(chkpass) OWNER TO postgres;

--
-- TOC entry 1064 (class 1247 OID 16400)
-- Dependencies: 21 20 6
-- Name: chkpass; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass (
    INTERNALLENGTH = 16,
    INPUT = chkpass_in,
    OUTPUT = chkpass_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.chkpass OWNER TO postgres;

--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 1064
-- Name: TYPE chkpass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE chkpass IS 'password type with checks';


--
-- TOC entry 1068 (class 0 OID 0)
-- Name: cube; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE cube;


--
-- TOC entry 22 (class 1255 OID 16405)
-- Dependencies: 6 1068
-- Name: cube_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_in(cstring) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_in';


ALTER FUNCTION public.cube_in(cstring) OWNER TO postgres;

--
-- TOC entry 23 (class 1255 OID 16406)
-- Dependencies: 6 1068
-- Name: cube_out(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_out(cube) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_out';


ALTER FUNCTION public.cube_out(cube) OWNER TO postgres;

--
-- TOC entry 1067 (class 1247 OID 16404)
-- Dependencies: 6 23 22
-- Name: cube; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE cube (
    INTERNALLENGTH = variable,
    INPUT = cube_in,
    OUTPUT = cube_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.cube OWNER TO postgres;

--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 1067
-- Name: TYPE cube; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE cube IS 'multi-dimensional cube ''(FLOAT-1, FLOAT-2, ..., FLOAT-N), (FLOAT-1, FLOAT-2, ..., FLOAT-N)''';


--
-- TOC entry 1070 (class 1247 OID 16410)
-- Dependencies: 6 2778
-- Name: dblink_pkey_results; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE dblink_pkey_results AS (
	"position" integer,
	colname text
);


ALTER TYPE public.dblink_pkey_results OWNER TO postgres;

--
-- TOC entry 1073 (class 0 OID 0)
-- Name: ean13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ean13;


--
-- TOC entry 24 (class 1255 OID 16412)
-- Dependencies: 6 1073
-- Name: ean13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_in(cstring) RETURNS ean13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_in';


ALTER FUNCTION public.ean13_in(cstring) OWNER TO postgres;

--
-- TOC entry 25 (class 1255 OID 16413)
-- Dependencies: 6 1073
-- Name: ean13_out(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(ean13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(ean13) OWNER TO postgres;

--
-- TOC entry 1072 (class 1247 OID 16411)
-- Dependencies: 25 6 24
-- Name: ean13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ean13 (
    INTERNALLENGTH = 8,
    INPUT = ean13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ean13 OWNER TO postgres;

--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 1072
-- Name: TYPE ean13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ean13 IS 'International European Article Number (EAN13)';


--
-- TOC entry 26 (class 1255 OID 16415)
-- Dependencies: 6 1067
-- Name: cube_dim(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_dim(cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_dim';


ALTER FUNCTION public.cube_dim(cube) OWNER TO postgres;

--
-- TOC entry 27 (class 1255 OID 16416)
-- Dependencies: 6 1067 1067
-- Name: cube_distance(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_distance(cube, cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_distance';


ALTER FUNCTION public.cube_distance(cube, cube) OWNER TO postgres;

--
-- TOC entry 28 (class 1255 OID 16417)
-- Dependencies: 1067 6
-- Name: cube_is_point(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_is_point(cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_is_point';


ALTER FUNCTION public.cube_is_point(cube) OWNER TO postgres;

--
-- TOC entry 29 (class 1255 OID 16418)
-- Dependencies: 6
-- Name: earth(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '6378168'::float8$$;


ALTER FUNCTION public.earth() OWNER TO postgres;

--
-- TOC entry 1075 (class 1247 OID 16419)
-- Dependencies: 1076 1077 1078 6 1067 23
-- Name: earth; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN earth AS cube
	CONSTRAINT not_3d CHECK ((cube_dim(VALUE) <= 3))
	CONSTRAINT not_point CHECK (cube_is_point(VALUE))
	CONSTRAINT on_surface CHECK ((abs(((cube_distance(VALUE, '(0)'::cube) / earth()) - (1)::double precision)) < (0.00000099999999999999995)::double precision));


ALTER DOMAIN public.earth OWNER TO postgres;

--
-- TOC entry 1079 (class 1247 OID 16425)
-- Dependencies: 6 2779
-- Name: frame; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE frame AS (
	level integer,
	targetname text,
	func oid,
	linenumber integer,
	args text
);


ALTER TYPE public.frame OWNER TO postgres;

--
-- TOC entry 1082 (class 0 OID 0)
-- Name: gbtreekey16; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey16;


--
-- TOC entry 30 (class 1255 OID 16427)
-- Dependencies: 6 1082
-- Name: gbtreekey16_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey16_in(cstring) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey16_in(cstring) OWNER TO postgres;

--
-- TOC entry 31 (class 1255 OID 16428)
-- Dependencies: 6 1082
-- Name: gbtreekey16_out(gbtreekey16); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey16_out(gbtreekey16) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey16_out(gbtreekey16) OWNER TO postgres;

--
-- TOC entry 1081 (class 1247 OID 16426)
-- Dependencies: 6 30 31
-- Name: gbtreekey16; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey16 (
    INTERNALLENGTH = 16,
    INPUT = gbtreekey16_in,
    OUTPUT = gbtreekey16_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey16 OWNER TO postgres;

--
-- TOC entry 1085 (class 0 OID 0)
-- Name: gbtreekey32; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey32;


--
-- TOC entry 32 (class 1255 OID 16431)
-- Dependencies: 6 1085
-- Name: gbtreekey32_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey32_in(cstring) RETURNS gbtreekey32
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey32_in(cstring) OWNER TO postgres;

--
-- TOC entry 33 (class 1255 OID 16432)
-- Dependencies: 6 1085
-- Name: gbtreekey32_out(gbtreekey32); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey32_out(gbtreekey32) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey32_out(gbtreekey32) OWNER TO postgres;

--
-- TOC entry 1084 (class 1247 OID 16430)
-- Dependencies: 32 33 6
-- Name: gbtreekey32; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey32 (
    INTERNALLENGTH = 32,
    INPUT = gbtreekey32_in,
    OUTPUT = gbtreekey32_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey32 OWNER TO postgres;

--
-- TOC entry 1088 (class 0 OID 0)
-- Name: gbtreekey4; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey4;


--
-- TOC entry 34 (class 1255 OID 16435)
-- Dependencies: 6 1088
-- Name: gbtreekey4_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey4_in(cstring) RETURNS gbtreekey4
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey4_in(cstring) OWNER TO postgres;

--
-- TOC entry 35 (class 1255 OID 16436)
-- Dependencies: 6 1088
-- Name: gbtreekey4_out(gbtreekey4); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey4_out(gbtreekey4) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey4_out(gbtreekey4) OWNER TO postgres;

--
-- TOC entry 1087 (class 1247 OID 16434)
-- Dependencies: 6 34 35
-- Name: gbtreekey4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey4 (
    INTERNALLENGTH = 4,
    INPUT = gbtreekey4_in,
    OUTPUT = gbtreekey4_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey4 OWNER TO postgres;

--
-- TOC entry 1091 (class 0 OID 0)
-- Name: gbtreekey8; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey8;


--
-- TOC entry 36 (class 1255 OID 16439)
-- Dependencies: 6 1091
-- Name: gbtreekey8_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey8_in(cstring) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey8_in(cstring) OWNER TO postgres;

--
-- TOC entry 37 (class 1255 OID 16440)
-- Dependencies: 6 1091
-- Name: gbtreekey8_out(gbtreekey8); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey8_out(gbtreekey8) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey8_out(gbtreekey8) OWNER TO postgres;

--
-- TOC entry 1090 (class 1247 OID 16438)
-- Dependencies: 6 36 37
-- Name: gbtreekey8; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey8 (
    INTERNALLENGTH = 8,
    INPUT = gbtreekey8_in,
    OUTPUT = gbtreekey8_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey8 OWNER TO postgres;

--
-- TOC entry 1094 (class 0 OID 0)
-- Name: gbtreekey_var; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey_var;


--
-- TOC entry 38 (class 1255 OID 16443)
-- Dependencies: 6 1094
-- Name: gbtreekey_var_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey_var_in(cstring) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey_var_in(cstring) OWNER TO postgres;

--
-- TOC entry 39 (class 1255 OID 16444)
-- Dependencies: 6 1094
-- Name: gbtreekey_var_out(gbtreekey_var); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey_var_out(gbtreekey_var) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey_var_out(gbtreekey_var) OWNER TO postgres;

--
-- TOC entry 1093 (class 1247 OID 16442)
-- Dependencies: 6 38 39
-- Name: gbtreekey_var; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey_var (
    INTERNALLENGTH = variable,
    INPUT = gbtreekey_var_in,
    OUTPUT = gbtreekey_var_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.gbtreekey_var OWNER TO postgres;

--
-- TOC entry 1097 (class 0 OID 0)
-- Name: ghstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore;


--
-- TOC entry 40 (class 1255 OID 16447)
-- Dependencies: 6 1097
-- Name: ghstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_in(cstring) RETURNS ghstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_in';


ALTER FUNCTION public.ghstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 41 (class 1255 OID 16448)
-- Dependencies: 6 1097
-- Name: ghstore_out(ghstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_out(ghstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_out';


ALTER FUNCTION public.ghstore_out(ghstore) OWNER TO postgres;

--
-- TOC entry 1096 (class 1247 OID 16446)
-- Dependencies: 6 40 41
-- Name: ghstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore (
    INTERNALLENGTH = variable,
    INPUT = ghstore_in,
    OUTPUT = ghstore_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ghstore OWNER TO postgres;

--
-- TOC entry 1100 (class 0 OID 0)
-- Name: gtrgm; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gtrgm;


--
-- TOC entry 42 (class 1255 OID 16451)
-- Dependencies: 6 1100
-- Name: gtrgm_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_in(cstring) RETURNS gtrgm
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'gtrgm_in';


ALTER FUNCTION public.gtrgm_in(cstring) OWNER TO postgres;

--
-- TOC entry 8 (class 1255 OID 16452)
-- Dependencies: 6 1100
-- Name: gtrgm_out(gtrgm); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_out(gtrgm) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'gtrgm_out';


ALTER FUNCTION public.gtrgm_out(gtrgm) OWNER TO postgres;

--
-- TOC entry 1099 (class 1247 OID 16450)
-- Dependencies: 6 8 42
-- Name: gtrgm; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gtrgm (
    INTERNALLENGTH = variable,
    INPUT = gtrgm_in,
    OUTPUT = gtrgm_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gtrgm OWNER TO postgres;

--
-- TOC entry 1103 (class 0 OID 0)
-- Name: hstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore;


--
-- TOC entry 43 (class 1255 OID 16455)
-- Dependencies: 6 1103
-- Name: hstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_in(cstring) RETURNS hstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_in';


ALTER FUNCTION public.hstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 44 (class 1255 OID 16456)
-- Dependencies: 6 1103
-- Name: hstore_out(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_out(hstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_out';


ALTER FUNCTION public.hstore_out(hstore) OWNER TO postgres;

--
-- TOC entry 1102 (class 1247 OID 16454)
-- Dependencies: 43 44 6
-- Name: hstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore (
    INTERNALLENGTH = variable,
    INPUT = hstore_in,
    OUTPUT = hstore_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.hstore OWNER TO postgres;

--
-- TOC entry 1106 (class 0 OID 0)
-- Name: intbig_gkey; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey;


--
-- TOC entry 45 (class 1255 OID 16459)
-- Dependencies: 6 1106
-- Name: _intbig_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_in(cstring) RETURNS intbig_gkey
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_intbig_in';


ALTER FUNCTION public._intbig_in(cstring) OWNER TO postgres;

--
-- TOC entry 46 (class 1255 OID 16460)
-- Dependencies: 6 1106
-- Name: _intbig_out(intbig_gkey); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_out(intbig_gkey) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_intbig_out';


ALTER FUNCTION public._intbig_out(intbig_gkey) OWNER TO postgres;

--
-- TOC entry 1105 (class 1247 OID 16458)
-- Dependencies: 45 46 6
-- Name: intbig_gkey; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey (
    INTERNALLENGTH = variable,
    INPUT = _intbig_in,
    OUTPUT = _intbig_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.intbig_gkey OWNER TO postgres;

--
-- TOC entry 1109 (class 0 OID 0)
-- Name: isbn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn;


--
-- TOC entry 47 (class 1255 OID 16463)
-- Dependencies: 6 1109
-- Name: isbn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn_in(cstring) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_in';


ALTER FUNCTION public.isbn_in(cstring) OWNER TO postgres;

--
-- TOC entry 48 (class 1255 OID 16464)
-- Dependencies: 6 1109
-- Name: isn_out(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(isbn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(isbn) OWNER TO postgres;

--
-- TOC entry 1108 (class 1247 OID 16462)
-- Dependencies: 6 47 48
-- Name: isbn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn (
    INTERNALLENGTH = 8,
    INPUT = isbn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn OWNER TO postgres;

--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 1108
-- Name: TYPE isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE isbn IS 'International Standard Book Number (ISBN)';


--
-- TOC entry 1112 (class 0 OID 0)
-- Name: isbn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn13;


--
-- TOC entry 49 (class 1255 OID 16467)
-- Dependencies: 6 1112
-- Name: ean13_out(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(isbn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(isbn13) OWNER TO postgres;

--
-- TOC entry 50 (class 1255 OID 16468)
-- Dependencies: 6 1112
-- Name: isbn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn13_in(cstring) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_in';


ALTER FUNCTION public.isbn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1111 (class 1247 OID 16466)
-- Dependencies: 49 50 6
-- Name: isbn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn13 (
    INTERNALLENGTH = 8,
    INPUT = isbn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn13 OWNER TO postgres;

--
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 1111
-- Name: TYPE isbn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE isbn13 IS 'International Standard Book Number 13 (ISBN13)';


--
-- TOC entry 1115 (class 0 OID 0)
-- Name: ismn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn;


--
-- TOC entry 51 (class 1255 OID 16471)
-- Dependencies: 6 1115
-- Name: ismn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn_in(cstring) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_in';


ALTER FUNCTION public.ismn_in(cstring) OWNER TO postgres;

--
-- TOC entry 52 (class 1255 OID 16472)
-- Dependencies: 6 1115
-- Name: isn_out(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(ismn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(ismn) OWNER TO postgres;

--
-- TOC entry 1114 (class 1247 OID 16470)
-- Dependencies: 52 51 6
-- Name: ismn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn (
    INTERNALLENGTH = 8,
    INPUT = ismn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn OWNER TO postgres;

--
-- TOC entry 3238 (class 0 OID 0)
-- Dependencies: 1114
-- Name: TYPE ismn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ismn IS 'International Standard Music Number (ISMN)';


--
-- TOC entry 1118 (class 0 OID 0)
-- Name: ismn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn13;


--
-- TOC entry 53 (class 1255 OID 16475)
-- Dependencies: 6 1118
-- Name: ean13_out(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(ismn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(ismn13) OWNER TO postgres;

--
-- TOC entry 54 (class 1255 OID 16476)
-- Dependencies: 6 1118
-- Name: ismn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn13_in(cstring) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_in';


ALTER FUNCTION public.ismn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1117 (class 1247 OID 16474)
-- Dependencies: 6 53 54
-- Name: ismn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn13 (
    INTERNALLENGTH = 8,
    INPUT = ismn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn13 OWNER TO postgres;

--
-- TOC entry 3239 (class 0 OID 0)
-- Dependencies: 1117
-- Name: TYPE ismn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ismn13 IS 'International Standard Music Number 13 (ISMN13)';


--
-- TOC entry 1121 (class 0 OID 0)
-- Name: issn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn;


--
-- TOC entry 55 (class 1255 OID 16479)
-- Dependencies: 6 1121
-- Name: isn_out(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(issn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(issn) OWNER TO postgres;

--
-- TOC entry 56 (class 1255 OID 16480)
-- Dependencies: 6 1121
-- Name: issn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn_in(cstring) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_in';


ALTER FUNCTION public.issn_in(cstring) OWNER TO postgres;

--
-- TOC entry 1120 (class 1247 OID 16478)
-- Dependencies: 6 56 55
-- Name: issn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn (
    INTERNALLENGTH = 8,
    INPUT = issn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn OWNER TO postgres;

--
-- TOC entry 3240 (class 0 OID 0)
-- Dependencies: 1120
-- Name: TYPE issn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE issn IS 'International Standard Serial Number (ISSN)';


--
-- TOC entry 1124 (class 0 OID 0)
-- Name: issn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn13;


--
-- TOC entry 57 (class 1255 OID 16483)
-- Dependencies: 6 1124
-- Name: ean13_out(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(issn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(issn13) OWNER TO postgres;

--
-- TOC entry 58 (class 1255 OID 16484)
-- Dependencies: 6 1124
-- Name: issn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn13_in(cstring) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_in';


ALTER FUNCTION public.issn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1123 (class 1247 OID 16482)
-- Dependencies: 58 57 6
-- Name: issn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn13 (
    INTERNALLENGTH = 8,
    INPUT = issn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn13 OWNER TO postgres;

--
-- TOC entry 3241 (class 0 OID 0)
-- Dependencies: 1123
-- Name: TYPE issn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE issn13 IS 'International Standard Serial Number 13 (ISSN13)';


--
-- TOC entry 1126 (class 1247 OID 16486)
-- Dependencies: 6
-- Name: lo; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN lo AS oid;


ALTER DOMAIN public.lo OWNER TO postgres;

--
-- TOC entry 1128 (class 0 OID 0)
-- Name: lquery; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lquery;


--
-- TOC entry 59 (class 1255 OID 16488)
-- Dependencies: 6 1128
-- Name: lquery_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lquery_in(cstring) RETURNS lquery
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'lquery_in';


ALTER FUNCTION public.lquery_in(cstring) OWNER TO postgres;

--
-- TOC entry 60 (class 1255 OID 16489)
-- Dependencies: 6 1128
-- Name: lquery_out(lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lquery_out(lquery) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'lquery_out';


ALTER FUNCTION public.lquery_out(lquery) OWNER TO postgres;

--
-- TOC entry 1127 (class 1247 OID 16487)
-- Dependencies: 59 60 6
-- Name: lquery; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lquery (
    INTERNALLENGTH = variable,
    INPUT = lquery_in,
    OUTPUT = lquery_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.lquery OWNER TO postgres;

--
-- TOC entry 1131 (class 0 OID 0)
-- Name: ltree; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree;


--
-- TOC entry 61 (class 1255 OID 16492)
-- Dependencies: 6 1131
-- Name: ltree_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_in(cstring) RETURNS ltree
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_in';


ALTER FUNCTION public.ltree_in(cstring) OWNER TO postgres;

--
-- TOC entry 62 (class 1255 OID 16493)
-- Dependencies: 6 1131
-- Name: ltree_out(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_out(ltree) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_out';


ALTER FUNCTION public.ltree_out(ltree) OWNER TO postgres;

--
-- TOC entry 1130 (class 1247 OID 16491)
-- Dependencies: 61 6 62
-- Name: ltree; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree (
    INTERNALLENGTH = variable,
    INPUT = ltree_in,
    OUTPUT = ltree_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltree OWNER TO postgres;

--
-- TOC entry 1134 (class 0 OID 0)
-- Name: ltree_gist; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree_gist;


--
-- TOC entry 63 (class 1255 OID 16496)
-- Dependencies: 6 1134
-- Name: ltree_gist_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gist_in(cstring) RETURNS ltree_gist
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_gist_in';


ALTER FUNCTION public.ltree_gist_in(cstring) OWNER TO postgres;

--
-- TOC entry 64 (class 1255 OID 16497)
-- Dependencies: 6 1134
-- Name: ltree_gist_out(ltree_gist); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gist_out(ltree_gist) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_gist_out';


ALTER FUNCTION public.ltree_gist_out(ltree_gist) OWNER TO postgres;

--
-- TOC entry 1133 (class 1247 OID 16495)
-- Dependencies: 63 6 64
-- Name: ltree_gist; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree_gist (
    INTERNALLENGTH = variable,
    INPUT = ltree_gist_in,
    OUTPUT = ltree_gist_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ltree_gist OWNER TO postgres;

--
-- TOC entry 1137 (class 0 OID 0)
-- Name: ltxtquery; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltxtquery;


--
-- TOC entry 65 (class 1255 OID 16500)
-- Dependencies: 6 1137
-- Name: ltxtq_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_in(cstring) RETURNS ltxtquery
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltxtq_in';


ALTER FUNCTION public.ltxtq_in(cstring) OWNER TO postgres;

--
-- TOC entry 66 (class 1255 OID 16501)
-- Dependencies: 6 1137
-- Name: ltxtq_out(ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_out(ltxtquery) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltxtq_out';


ALTER FUNCTION public.ltxtq_out(ltxtquery) OWNER TO postgres;

--
-- TOC entry 1136 (class 1247 OID 16499)
-- Dependencies: 65 66 6
-- Name: ltxtquery; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltxtquery (
    INTERNALLENGTH = variable,
    INPUT = ltxtq_in,
    OUTPUT = ltxtq_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltxtquery OWNER TO postgres;

--
-- TOC entry 1139 (class 1247 OID 16505)
-- Dependencies: 6 2780
-- Name: proxyinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE proxyinfo AS (
	serverversionstr text,
	serverversionnum integer,
	proxyapiver integer,
	serverprocessid integer
);


ALTER TYPE public.proxyinfo OWNER TO postgres;

--
-- TOC entry 1142 (class 0 OID 0)
-- Name: query_int; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int;


--
-- TOC entry 67 (class 1255 OID 16507)
-- Dependencies: 6 1142
-- Name: bqarr_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_in(cstring) RETURNS query_int
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'bqarr_in';


ALTER FUNCTION public.bqarr_in(cstring) OWNER TO postgres;

--
-- TOC entry 68 (class 1255 OID 16508)
-- Dependencies: 6 1142
-- Name: bqarr_out(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_out(query_int) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'bqarr_out';


ALTER FUNCTION public.bqarr_out(query_int) OWNER TO postgres;

--
-- TOC entry 1141 (class 1247 OID 16506)
-- Dependencies: 67 68 6
-- Name: query_int; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int (
    INTERNALLENGTH = variable,
    INPUT = bqarr_in,
    OUTPUT = bqarr_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.query_int OWNER TO postgres;

--
-- TOC entry 1145 (class 0 OID 0)
-- Name: seg; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE seg;


--
-- TOC entry 69 (class 1255 OID 16511)
-- Dependencies: 6 1145
-- Name: seg_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_in(cstring) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_in';


ALTER FUNCTION public.seg_in(cstring) OWNER TO postgres;

--
-- TOC entry 70 (class 1255 OID 16512)
-- Dependencies: 6 1145
-- Name: seg_out(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_out(seg) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_out';


ALTER FUNCTION public.seg_out(seg) OWNER TO postgres;

--
-- TOC entry 1144 (class 1247 OID 16510)
-- Dependencies: 69 70 6
-- Name: seg; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE seg (
    INTERNALLENGTH = 12,
    INPUT = seg_in,
    OUTPUT = seg_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.seg OWNER TO postgres;

--
-- TOC entry 3242 (class 0 OID 0)
-- Dependencies: 1144
-- Name: TYPE seg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE seg IS 'floating point interval ''FLOAT .. FLOAT'', ''.. FLOAT'', ''FLOAT ..'' or ''FLOAT''';


--
-- TOC entry 1147 (class 1247 OID 16516)
-- Dependencies: 6 2781
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO postgres;

--
-- TOC entry 1149 (class 1247 OID 16519)
-- Dependencies: 6 2782
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO postgres;

--
-- TOC entry 1151 (class 1247 OID 16522)
-- Dependencies: 6 2783
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO postgres;

--
-- TOC entry 1153 (class 1247 OID 16525)
-- Dependencies: 6 2784
-- Name: targetinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE targetinfo AS (
	target oid,
	schema oid,
	nargs integer,
	argtypes oidvector,
	targetname name,
	argmodes "char"[],
	argnames text[],
	targetlang oid,
	fqname text,
	returnsset boolean,
	returntype oid
);


ALTER TYPE public.targetinfo OWNER TO postgres;

--
-- TOC entry 1156 (class 0 OID 0)
-- Name: upc; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE upc;


--
-- TOC entry 71 (class 1255 OID 16527)
-- Dependencies: 6 1156
-- Name: isn_out(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(upc) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(upc) OWNER TO postgres;

--
-- TOC entry 72 (class 1255 OID 16528)
-- Dependencies: 6 1156
-- Name: upc_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION upc_in(cstring) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'upc_in';


ALTER FUNCTION public.upc_in(cstring) OWNER TO postgres;

--
-- TOC entry 1155 (class 1247 OID 16526)
-- Dependencies: 6 72 71
-- Name: upc; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE upc (
    INTERNALLENGTH = 8,
    INPUT = upc_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.upc OWNER TO postgres;

--
-- TOC entry 3243 (class 0 OID 0)
-- Dependencies: 1155
-- Name: TYPE upc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE upc IS 'Universal Product Code (UPC)';


--
-- TOC entry 1158 (class 1247 OID 16532)
-- Dependencies: 6 2785
-- Name: var; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE var AS (
	name text,
	varclass character(1),
	linenumber integer,
	isunique boolean,
	isconst boolean,
	isnotnull boolean,
	dtype oid,
	value text
);


ALTER TYPE public.var OWNER TO postgres;

--
-- TOC entry 73 (class 1255 OID 16533)
-- Dependencies: 6
-- Name: _int_contained(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contained(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_contained';


ALTER FUNCTION public._int_contained(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3244 (class 0 OID 0)
-- Dependencies: 73
-- Name: FUNCTION _int_contained(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contained(integer[], integer[]) IS 'contained in';


--
-- TOC entry 74 (class 1255 OID 16534)
-- Dependencies: 6
-- Name: _int_contains(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contains(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_contains';


ALTER FUNCTION public._int_contains(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3245 (class 0 OID 0)
-- Dependencies: 74
-- Name: FUNCTION _int_contains(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contains(integer[], integer[]) IS 'contains';


--
-- TOC entry 75 (class 1255 OID 16535)
-- Dependencies: 6
-- Name: _int_different(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_different(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_different';


ALTER FUNCTION public._int_different(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3246 (class 0 OID 0)
-- Dependencies: 75
-- Name: FUNCTION _int_different(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_different(integer[], integer[]) IS 'different';


--
-- TOC entry 76 (class 1255 OID 16536)
-- Dependencies: 6
-- Name: _int_inter(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_inter(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_inter';


ALTER FUNCTION public._int_inter(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 77 (class 1255 OID 16537)
-- Dependencies: 6
-- Name: _int_overlap(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_overlap(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_overlap';


ALTER FUNCTION public._int_overlap(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3247 (class 0 OID 0)
-- Dependencies: 77
-- Name: FUNCTION _int_overlap(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_overlap(integer[], integer[]) IS 'overlaps';


--
-- TOC entry 78 (class 1255 OID 16538)
-- Dependencies: 6
-- Name: _int_same(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_same(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_same';


ALTER FUNCTION public._int_same(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3248 (class 0 OID 0)
-- Dependencies: 78
-- Name: FUNCTION _int_same(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_same(integer[], integer[]) IS 'same as';


--
-- TOC entry 79 (class 1255 OID 16539)
-- Dependencies: 6
-- Name: _int_union(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_union(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_union';


ALTER FUNCTION public._int_union(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 80 (class 1255 OID 16540)
-- Dependencies: 6 1132 1129
-- Name: _lt_q_regex(ltree[], lquery[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _lt_q_regex(ltree[], lquery[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lt_q_regex';


ALTER FUNCTION public._lt_q_regex(ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 81 (class 1255 OID 16541)
-- Dependencies: 6 1129 1132
-- Name: _lt_q_rregex(lquery[], ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _lt_q_rregex(lquery[], ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lt_q_rregex';


ALTER FUNCTION public._lt_q_rregex(lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 82 (class 1255 OID 16542)
-- Dependencies: 1130 6 1132 1127
-- Name: _ltq_extract_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_extract_regex(ltree[], lquery) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_extract_regex';


ALTER FUNCTION public._ltq_extract_regex(ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 83 (class 1255 OID 16543)
-- Dependencies: 6 1132 1127
-- Name: _ltq_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_regex(ltree[], lquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_regex';


ALTER FUNCTION public._ltq_regex(ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 84 (class 1255 OID 16544)
-- Dependencies: 1127 1132 6
-- Name: _ltq_rregex(lquery, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_rregex(lquery, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_rregex';


ALTER FUNCTION public._ltq_rregex(lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 85 (class 1255 OID 16545)
-- Dependencies: 6
-- Name: _ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_compress';


ALTER FUNCTION public._ltree_compress(internal) OWNER TO postgres;

--
-- TOC entry 86 (class 1255 OID 16546)
-- Dependencies: 6
-- Name: _ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_consistent(internal, internal, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_consistent';


ALTER FUNCTION public._ltree_consistent(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 87 (class 1255 OID 16547)
-- Dependencies: 6 1130 1132 1130
-- Name: _ltree_extract_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_extract_isparent(ltree[], ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_extract_isparent';


ALTER FUNCTION public._ltree_extract_isparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 88 (class 1255 OID 16548)
-- Dependencies: 6 1132 1130 1130
-- Name: _ltree_extract_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_extract_risparent(ltree[], ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_extract_risparent';


ALTER FUNCTION public._ltree_extract_risparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 89 (class 1255 OID 16549)
-- Dependencies: 6 1132 1130
-- Name: _ltree_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_isparent(ltree[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_isparent';


ALTER FUNCTION public._ltree_isparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 90 (class 1255 OID 16550)
-- Dependencies: 6
-- Name: _ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_penalty';


ALTER FUNCTION public._ltree_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 91 (class 1255 OID 16551)
-- Dependencies: 6
-- Name: _ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_picksplit';


ALTER FUNCTION public._ltree_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 92 (class 1255 OID 16552)
-- Dependencies: 6 1130 1132
-- Name: _ltree_r_isparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_r_isparent(ltree, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_r_isparent';


ALTER FUNCTION public._ltree_r_isparent(ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 93 (class 1255 OID 16553)
-- Dependencies: 1132 6 1130
-- Name: _ltree_r_risparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_r_risparent(ltree, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_r_risparent';


ALTER FUNCTION public._ltree_r_risparent(ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 94 (class 1255 OID 16554)
-- Dependencies: 1130 6 1132
-- Name: _ltree_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_risparent(ltree[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_risparent';


ALTER FUNCTION public._ltree_risparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 95 (class 1255 OID 16555)
-- Dependencies: 6
-- Name: _ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_same';


ALTER FUNCTION public._ltree_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 96 (class 1255 OID 16556)
-- Dependencies: 6
-- Name: _ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_union(internal, internal) RETURNS integer
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_union';


ALTER FUNCTION public._ltree_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 97 (class 1255 OID 16557)
-- Dependencies: 6 1136 1132
-- Name: _ltxtq_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_exec(ltree[], ltxtquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_exec';


ALTER FUNCTION public._ltxtq_exec(ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 98 (class 1255 OID 16558)
-- Dependencies: 6 1136 1130 1132
-- Name: _ltxtq_extract_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_extract_exec(ltree[], ltxtquery) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_extract_exec';


ALTER FUNCTION public._ltxtq_extract_exec(ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 99 (class 1255 OID 16559)
-- Dependencies: 6 1136 1132
-- Name: _ltxtq_rexec(ltxtquery, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_rexec(ltxtquery, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_rexec';


ALTER FUNCTION public._ltxtq_rexec(ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 100 (class 1255 OID 16560)
-- Dependencies: 6 1102
-- Name: akeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION akeys(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'akeys';


ALTER FUNCTION public.akeys(hstore) OWNER TO postgres;

--
-- TOC entry 101 (class 1255 OID 16561)
-- Dependencies: 6
-- Name: armor(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION armor(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_armor';


ALTER FUNCTION public.armor(bytea) OWNER TO postgres;

--
-- TOC entry 102 (class 1255 OID 16562)
-- Dependencies: 6
-- Name: autoinc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION autoinc() RETURNS trigger
    LANGUAGE c
    AS '$libdir/autoinc', 'autoinc';


ALTER FUNCTION public.autoinc() OWNER TO postgres;

--
-- TOC entry 103 (class 1255 OID 16563)
-- Dependencies: 1102 6
-- Name: avals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION avals(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'avals';


ALTER FUNCTION public.avals(hstore) OWNER TO postgres;

--
-- TOC entry 104 (class 1255 OID 16564)
-- Dependencies: 6 1141
-- Name: boolop(integer[], query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION boolop(integer[], query_int) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'boolop';


ALTER FUNCTION public.boolop(integer[], query_int) OWNER TO postgres;

--
-- TOC entry 3249 (class 0 OID 0)
-- Dependencies: 104
-- Name: FUNCTION boolop(integer[], query_int); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION boolop(integer[], query_int) IS 'boolean operation with array';


--
-- TOC entry 105 (class 1255 OID 16565)
-- Dependencies: 6
-- Name: bt_metap(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_metap';


ALTER FUNCTION public.bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) OWNER TO postgres;

--
-- TOC entry 106 (class 1255 OID 16566)
-- Dependencies: 6
-- Name: bt_page_items(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_page_items';


ALTER FUNCTION public.bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) OWNER TO postgres;

--
-- TOC entry 107 (class 1255 OID 16567)
-- Dependencies: 6
-- Name: bt_page_stats(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_page_stats';


ALTER FUNCTION public.bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) OWNER TO postgres;

--
-- TOC entry 108 (class 1255 OID 16568)
-- Dependencies: 1072 6 1072
-- Name: btean13cmp(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 109 (class 1255 OID 16569)
-- Dependencies: 6 1111 1072
-- Name: btean13cmp(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 110 (class 1255 OID 16570)
-- Dependencies: 1072 1117 6
-- Name: btean13cmp(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 111 (class 1255 OID 16571)
-- Dependencies: 6 1072 1123
-- Name: btean13cmp(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 112 (class 1255 OID 16572)
-- Dependencies: 1072 1108 6
-- Name: btean13cmp(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 113 (class 1255 OID 16573)
-- Dependencies: 1072 1114 6
-- Name: btean13cmp(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 114 (class 1255 OID 16574)
-- Dependencies: 6 1072 1120
-- Name: btean13cmp(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, issn) OWNER TO postgres;

--
-- TOC entry 115 (class 1255 OID 16575)
-- Dependencies: 1072 1155 6
-- Name: btean13cmp(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, upc) OWNER TO postgres;

--
-- TOC entry 116 (class 1255 OID 16576)
-- Dependencies: 1111 1111 6
-- Name: btisbn13cmp(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 117 (class 1255 OID 16577)
-- Dependencies: 1111 1072 6
-- Name: btisbn13cmp(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 118 (class 1255 OID 16578)
-- Dependencies: 6 1108 1111
-- Name: btisbn13cmp(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 119 (class 1255 OID 16579)
-- Dependencies: 6 1108 1108
-- Name: btisbncmp(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 120 (class 1255 OID 16580)
-- Dependencies: 6 1072 1108
-- Name: btisbncmp(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 121 (class 1255 OID 16581)
-- Dependencies: 1108 6 1111
-- Name: btisbncmp(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 122 (class 1255 OID 16582)
-- Dependencies: 1117 6 1117
-- Name: btismn13cmp(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 123 (class 1255 OID 16583)
-- Dependencies: 1117 6 1072
-- Name: btismn13cmp(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 124 (class 1255 OID 16584)
-- Dependencies: 1117 6 1114
-- Name: btismn13cmp(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 125 (class 1255 OID 16585)
-- Dependencies: 1114 6 1114
-- Name: btismncmp(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 126 (class 1255 OID 16586)
-- Dependencies: 1114 6 1072
-- Name: btismncmp(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 127 (class 1255 OID 16587)
-- Dependencies: 1114 6 1117
-- Name: btismncmp(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 128 (class 1255 OID 16588)
-- Dependencies: 1123 6 1123
-- Name: btissn13cmp(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 129 (class 1255 OID 16589)
-- Dependencies: 1123 6 1072
-- Name: btissn13cmp(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 130 (class 1255 OID 16590)
-- Dependencies: 1123 6 1120
-- Name: btissn13cmp(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, issn) OWNER TO postgres;

--
-- TOC entry 131 (class 1255 OID 16591)
-- Dependencies: 6 1120 1120
-- Name: btissncmp(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, issn) OWNER TO postgres;

--
-- TOC entry 132 (class 1255 OID 16592)
-- Dependencies: 6 1120 1072
-- Name: btissncmp(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, ean13) OWNER TO postgres;

--
-- TOC entry 133 (class 1255 OID 16593)
-- Dependencies: 1123 6 1120
-- Name: btissncmp(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, issn13) OWNER TO postgres;

--
-- TOC entry 134 (class 1255 OID 16594)
-- Dependencies: 1155 6 1155
-- Name: btupccmp(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btupccmp(upc, upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btupccmp(upc, upc) OWNER TO postgres;

--
-- TOC entry 135 (class 1255 OID 16595)
-- Dependencies: 1155 6 1072
-- Name: btupccmp(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btupccmp(upc, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btupccmp(upc, ean13) OWNER TO postgres;

--
-- TOC entry 777 (class 1255 OID 18599)
-- Dependencies: 1229 6
-- Name: cantidad_acertada_est_exam(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_acertada_est_exam(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

CODIGO INTEGER;
EXAM INTEGER;
CANTIDAD INTEGER;

BEGIN

CODIGO = $1;
EXAM = $2;

SELECT COUNT(*) INTO CANTIDAD
FROM estudiante, respuesta, examen 
WHERE (estudiante.cod = respuesta.estudiante_cod) AND (respuesta.estudiante_cod = CODIGO) 
AND (examen.id = respuesta.examen_id) AND (examen.id = EXAM) AND (respuesta.acertada = TRUE);

RETURN CANTIDAD;

END $_$;


ALTER FUNCTION public.cantidad_acertada_est_exam(integer, integer) OWNER TO root;

--
-- TOC entry 778 (class 1255 OID 18600)
-- Dependencies: 1229 6
-- Name: cantidad_acertada_est_exam2(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_acertada_est_exam2(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

CODIGO INTEGER;
EXAM INTEGER;
CANTIDAD INTEGER;

BEGIN

CODIGO = $1;
EXAM = $2;

SELECT COUNT(*) INTO CANTIDAD
FROM estudiante, respuesta, examen 
WHERE (estudiante.cod = respuesta.estudiante_cod) AND (respuesta.estudiante_cod = CODIGO) 
AND (examen.id = respuesta.examen_id) AND (examen.id = EXAM) AND (respuesta.acertada = FALSE);

RETURN CANTIDAD;

END $_$;


ALTER FUNCTION public.cantidad_acertada_est_exam2(integer, integer) OWNER TO root;

--
-- TOC entry 136 (class 1255 OID 16596)
-- Dependencies: 6 1229
-- Name: cantidad_acertadas(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_acertadas(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

CODIGO INTEGER;
CANTIDAD INTEGER;

BEGIN

CODIGO = $1;

SELECT COUNT(*) INTO CANTIDAD FROM estudiante, respuesta WHERE (estudiante.cod = respuesta.estudiante_cod) AND (respuesta.estudiante_cod = CODIGO) AND (respuesta.acertada = TRUE);

RETURN CANTIDAD;

END $_$;


ALTER FUNCTION public.cantidad_acertadas(integer) OWNER TO root;

--
-- TOC entry 137 (class 1255 OID 16597)
-- Dependencies: 6 1229
-- Name: cantidad_area_exam(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_area_exam(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

AREA INTEGER;
EXAMEN2 INTEGER;
CANTIDAD INTEGER;

BEGIN 


AREA = $1;
EXAMEN2 = $2;

SELECT COUNT(*) INTO CANTIDAD 
FROM respuesta, examen, pregunta, areatematica 
WHERE (examen.id = respuesta.examen_id) and (respuesta.pregunta_id = pregunta.id)
and (pregunta.areatematica_id = areatematica.id) and  (respuesta.examen_id = EXAMEN2) 
and (pregunta.areatematica_id = AREA) and (respuesta.acertada = TRUE);

RETURN CANTIDAD;



END$_$;


ALTER FUNCTION public.cantidad_area_exam(integer, integer) OWNER TO root;

--
-- TOC entry 138 (class 1255 OID 16598)
-- Dependencies: 6 1229
-- Name: cantidad_area_exam2(integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_area_exam2(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

AREA INTEGER;
EXAMEN2 INTEGER;
CANTIDAD INTEGER;

BEGIN 


AREA = $1;
EXAMEN2 = $2;

SELECT COUNT(*) INTO CANTIDAD 
FROM respuesta, examen, pregunta, areatematica 
WHERE (examen.id = respuesta.examen_id) and (respuesta.pregunta_id = pregunta.id)
and (pregunta.areatematica_id = areatematica.id) and  (respuesta.examen_id = EXAMEN2) 
and (pregunta.areatematica_id = AREA) and (respuesta.acertada = FALSE);

RETURN CANTIDAD;



END$_$;


ALTER FUNCTION public.cantidad_area_exam2(integer, integer) OWNER TO root;

--
-- TOC entry 139 (class 1255 OID 16599)
-- Dependencies: 6 1229
-- Name: cantidad_erradas(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_erradas(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

CODIGO INTEGER;
CANTIDAD INTEGER;

BEGIN

CODIGO = $1;

SELECT COUNT(*) INTO CANTIDAD FROM estudiante, respuesta WHERE (estudiante.cod = respuesta.estudiante_cod) AND (respuesta.estudiante_cod = CODIGO) AND (respuesta.acertada = FALSE);

RETURN CANTIDAD;

END $_$;


ALTER FUNCTION public.cantidad_erradas(integer) OWNER TO root;

--
-- TOC entry 140 (class 1255 OID 16600)
-- Dependencies: 6 1229
-- Name: cantidad_exam_area_cod(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_exam_area_cod(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

AREA INTEGER;
EXAMEN2 INTEGER;
CANTIDAD INTEGER;
CODIGO INTEGER;

BEGIN 


AREA = $1;
EXAMEN2 = $2;
CODIGO = $3;

SELECT COUNT(*) INTO CANTIDAD 
FROM respuesta, examen, pregunta, areatematica , estudiante
WHERE (examen.id = respuesta.examen_id) and (respuesta.pregunta_id = pregunta.id)
and (pregunta.areatematica_id = areatematica.id) and  (respuesta.examen_id = EXAMEN2) 
and (pregunta.areatematica_id = AREA) and (estudiante.cod = respuesta.estudiante_cod) 
and (respuesta.estudiante_cod = CODIGO ) and (respuesta.acertada = TRUE);




RETURN CANTIDAD;



END$_$;


ALTER FUNCTION public.cantidad_exam_area_cod(integer, integer, integer) OWNER TO root;

--
-- TOC entry 141 (class 1255 OID 16601)
-- Dependencies: 1229 6
-- Name: cantidad_exam_area_cod2(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION cantidad_exam_area_cod2(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

AREA INTEGER;
EXAMEN2 INTEGER;
CANTIDAD INTEGER;
CODIGO INTEGER;

BEGIN 


AREA = $1;
EXAMEN2 = $2;
CODIGO = $3;

SELECT COUNT(*) INTO CANTIDAD 
FROM respuesta, examen, pregunta, areatematica , estudiante
WHERE (examen.id = respuesta.examen_id) and (respuesta.pregunta_id = pregunta.id)
and (pregunta.areatematica_id = areatematica.id) and  (respuesta.examen_id = EXAMEN2) 
and (pregunta.areatematica_id = AREA) and (estudiante.cod = respuesta.estudiante_cod) 
and (respuesta.estudiante_cod = CODIGO ) and (respuesta.acertada = FALSE);




RETURN CANTIDAD;



END$_$;


ALTER FUNCTION public.cantidad_exam_area_cod2(integer, integer, integer) OWNER TO root;

--
-- TOC entry 142 (class 1255 OID 16602)
-- Dependencies: 6
-- Name: check_foreign_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_foreign_key() RETURNS trigger
    LANGUAGE c
    AS '$libdir/refint', 'check_foreign_key';


ALTER FUNCTION public.check_foreign_key() OWNER TO postgres;

--
-- TOC entry 143 (class 1255 OID 16603)
-- Dependencies: 6
-- Name: check_primary_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_primary_key() RETURNS trigger
    LANGUAGE c
    AS '$libdir/refint', 'check_primary_key';


ALTER FUNCTION public.check_primary_key() OWNER TO postgres;

--
-- TOC entry 144 (class 1255 OID 16604)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 145 (class 1255 OID 16605)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 146 (class 1255 OID 16606)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 147 (class 1255 OID 16607)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 148 (class 1255 OID 16608)
-- Dependencies: 6
-- Name: crosstab(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text) OWNER TO postgres;

--
-- TOC entry 149 (class 1255 OID 16609)
-- Dependencies: 6
-- Name: crosstab(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text, integer) OWNER TO postgres;

--
-- TOC entry 150 (class 1255 OID 16610)
-- Dependencies: 6
-- Name: crosstab(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab_hash';


ALTER FUNCTION public.crosstab(text, text) OWNER TO postgres;

--
-- TOC entry 151 (class 1255 OID 16611)
-- Dependencies: 6 1147
-- Name: crosstab2(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab2(text) RETURNS SETOF tablefunc_crosstab_2
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab2(text) OWNER TO postgres;

--
-- TOC entry 152 (class 1255 OID 16612)
-- Dependencies: 1149 6
-- Name: crosstab3(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab3(text) RETURNS SETOF tablefunc_crosstab_3
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab3(text) OWNER TO postgres;

--
-- TOC entry 153 (class 1255 OID 16613)
-- Dependencies: 1151 6
-- Name: crosstab4(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab4(text) RETURNS SETOF tablefunc_crosstab_4
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab4(text) OWNER TO postgres;

--
-- TOC entry 154 (class 1255 OID 16614)
-- Dependencies: 6
-- Name: crypt(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crypt(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_crypt';


ALTER FUNCTION public.crypt(text, text) OWNER TO postgres;

--
-- TOC entry 155 (class 1255 OID 16615)
-- Dependencies: 6 1067
-- Name: cube(double precision[], double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision[], double precision[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_a_f8_f8';


ALTER FUNCTION public.cube(double precision[], double precision[]) OWNER TO postgres;

--
-- TOC entry 156 (class 1255 OID 16616)
-- Dependencies: 6 1067
-- Name: cube(double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_a_f8';


ALTER FUNCTION public.cube(double precision[]) OWNER TO postgres;

--
-- TOC entry 157 (class 1255 OID 16617)
-- Dependencies: 6 1067
-- Name: cube(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8';


ALTER FUNCTION public.cube(double precision) OWNER TO postgres;

--
-- TOC entry 158 (class 1255 OID 16618)
-- Dependencies: 6 1067
-- Name: cube(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8_f8';


ALTER FUNCTION public.cube(double precision, double precision) OWNER TO postgres;

--
-- TOC entry 159 (class 1255 OID 16619)
-- Dependencies: 1067 6 1067
-- Name: cube(cube, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(cube, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8';


ALTER FUNCTION public.cube(cube, double precision) OWNER TO postgres;

--
-- TOC entry 160 (class 1255 OID 16620)
-- Dependencies: 1067 6 1067
-- Name: cube(cube, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(cube, double precision, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8_f8';


ALTER FUNCTION public.cube(cube, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 161 (class 1255 OID 16621)
-- Dependencies: 1067 6 1067
-- Name: cube_cmp(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_cmp(cube, cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_cmp';


ALTER FUNCTION public.cube_cmp(cube, cube) OWNER TO postgres;

--
-- TOC entry 3250 (class 0 OID 0)
-- Dependencies: 161
-- Name: FUNCTION cube_cmp(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_cmp(cube, cube) IS 'btree comparison function';


--
-- TOC entry 162 (class 1255 OID 16622)
-- Dependencies: 1067 6 1067
-- Name: cube_contained(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_contained(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contained';


ALTER FUNCTION public.cube_contained(cube, cube) OWNER TO postgres;

--
-- TOC entry 3251 (class 0 OID 0)
-- Dependencies: 162
-- Name: FUNCTION cube_contained(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_contained(cube, cube) IS 'contained in';


--
-- TOC entry 163 (class 1255 OID 16623)
-- Dependencies: 1067 6 1067
-- Name: cube_contains(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_contains(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contains';


ALTER FUNCTION public.cube_contains(cube, cube) OWNER TO postgres;

--
-- TOC entry 3252 (class 0 OID 0)
-- Dependencies: 163
-- Name: FUNCTION cube_contains(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_contains(cube, cube) IS 'contains';


--
-- TOC entry 164 (class 1255 OID 16624)
-- Dependencies: 6 1067 1067
-- Name: cube_enlarge(cube, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_enlarge(cube, double precision, integer) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_enlarge';


ALTER FUNCTION public.cube_enlarge(cube, double precision, integer) OWNER TO postgres;

--
-- TOC entry 165 (class 1255 OID 16625)
-- Dependencies: 1067 6 1067
-- Name: cube_eq(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_eq(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_eq';


ALTER FUNCTION public.cube_eq(cube, cube) OWNER TO postgres;

--
-- TOC entry 3253 (class 0 OID 0)
-- Dependencies: 165
-- Name: FUNCTION cube_eq(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_eq(cube, cube) IS 'same as';


--
-- TOC entry 166 (class 1255 OID 16626)
-- Dependencies: 1067 6 1067
-- Name: cube_ge(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ge(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ge';


ALTER FUNCTION public.cube_ge(cube, cube) OWNER TO postgres;

--
-- TOC entry 3254 (class 0 OID 0)
-- Dependencies: 166
-- Name: FUNCTION cube_ge(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_ge(cube, cube) IS 'greater than or equal to';


--
-- TOC entry 167 (class 1255 OID 16627)
-- Dependencies: 1067 6 1067
-- Name: cube_gt(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_gt(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_gt';


ALTER FUNCTION public.cube_gt(cube, cube) OWNER TO postgres;

--
-- TOC entry 3255 (class 0 OID 0)
-- Dependencies: 167
-- Name: FUNCTION cube_gt(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_gt(cube, cube) IS 'greater than';


--
-- TOC entry 168 (class 1255 OID 16628)
-- Dependencies: 1067 6 1067 1067
-- Name: cube_inter(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_inter(cube, cube) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_inter';


ALTER FUNCTION public.cube_inter(cube, cube) OWNER TO postgres;

--
-- TOC entry 169 (class 1255 OID 16629)
-- Dependencies: 1067 6 1067
-- Name: cube_le(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_le(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_le';


ALTER FUNCTION public.cube_le(cube, cube) OWNER TO postgres;

--
-- TOC entry 3256 (class 0 OID 0)
-- Dependencies: 169
-- Name: FUNCTION cube_le(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_le(cube, cube) IS 'lower than or equal to';


--
-- TOC entry 170 (class 1255 OID 16630)
-- Dependencies: 6 1067
-- Name: cube_ll_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ll_coord(cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ll_coord';


ALTER FUNCTION public.cube_ll_coord(cube, integer) OWNER TO postgres;

--
-- TOC entry 171 (class 1255 OID 16631)
-- Dependencies: 1067 6 1067
-- Name: cube_lt(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_lt(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_lt';


ALTER FUNCTION public.cube_lt(cube, cube) OWNER TO postgres;

--
-- TOC entry 3257 (class 0 OID 0)
-- Dependencies: 171
-- Name: FUNCTION cube_lt(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_lt(cube, cube) IS 'lower than';


--
-- TOC entry 172 (class 1255 OID 16632)
-- Dependencies: 1067 6 1067
-- Name: cube_ne(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ne(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ne';


ALTER FUNCTION public.cube_ne(cube, cube) OWNER TO postgres;

--
-- TOC entry 3258 (class 0 OID 0)
-- Dependencies: 172
-- Name: FUNCTION cube_ne(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_ne(cube, cube) IS 'different';


--
-- TOC entry 173 (class 1255 OID 16633)
-- Dependencies: 1067 6 1067
-- Name: cube_overlap(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_overlap(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_overlap';


ALTER FUNCTION public.cube_overlap(cube, cube) OWNER TO postgres;

--
-- TOC entry 3259 (class 0 OID 0)
-- Dependencies: 173
-- Name: FUNCTION cube_overlap(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_overlap(cube, cube) IS 'overlaps';


--
-- TOC entry 174 (class 1255 OID 16634)
-- Dependencies: 6 1067
-- Name: cube_size(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_size(cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_size';


ALTER FUNCTION public.cube_size(cube) OWNER TO postgres;

--
-- TOC entry 175 (class 1255 OID 16635)
-- Dependencies: 1067 6 1067
-- Name: cube_subset(cube, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_subset(cube, integer[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_subset';


ALTER FUNCTION public.cube_subset(cube, integer[]) OWNER TO postgres;

--
-- TOC entry 176 (class 1255 OID 16636)
-- Dependencies: 6 1067 1067 1067
-- Name: cube_union(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_union(cube, cube) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_union';


ALTER FUNCTION public.cube_union(cube, cube) OWNER TO postgres;

--
-- TOC entry 177 (class 1255 OID 16637)
-- Dependencies: 1067 6
-- Name: cube_ur_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ur_coord(cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ur_coord';


ALTER FUNCTION public.cube_ur_coord(cube, integer) OWNER TO postgres;

--
-- TOC entry 178 (class 1255 OID 16638)
-- Dependencies: 6
-- Name: dblink(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text) OWNER TO postgres;

--
-- TOC entry 179 (class 1255 OID 16639)
-- Dependencies: 6
-- Name: dblink(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 180 (class 1255 OID 16640)
-- Dependencies: 6
-- Name: dblink(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text) OWNER TO postgres;

--
-- TOC entry 181 (class 1255 OID 16641)
-- Dependencies: 6
-- Name: dblink(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, boolean) OWNER TO postgres;

--
-- TOC entry 182 (class 1255 OID 16642)
-- Dependencies: 6
-- Name: dblink_build_sql_delete(text, int2vector, integer, text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_delete(text, int2vector, integer, text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_delete';


ALTER FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[]) OWNER TO postgres;

--
-- TOC entry 183 (class 1255 OID 16643)
-- Dependencies: 6
-- Name: dblink_build_sql_insert(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_insert(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_insert';


ALTER FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[]) OWNER TO postgres;

--
-- TOC entry 184 (class 1255 OID 16644)
-- Dependencies: 6
-- Name: dblink_build_sql_update(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_update(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_update';


ALTER FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[]) OWNER TO postgres;

--
-- TOC entry 185 (class 1255 OID 16645)
-- Dependencies: 6
-- Name: dblink_cancel_query(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_cancel_query(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_cancel_query';


ALTER FUNCTION public.dblink_cancel_query(text) OWNER TO postgres;

--
-- TOC entry 186 (class 1255 OID 16646)
-- Dependencies: 6
-- Name: dblink_close(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text) OWNER TO postgres;

--
-- TOC entry 187 (class 1255 OID 16647)
-- Dependencies: 6
-- Name: dblink_close(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, boolean) OWNER TO postgres;

--
-- TOC entry 188 (class 1255 OID 16648)
-- Dependencies: 6
-- Name: dblink_close(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text) OWNER TO postgres;

--
-- TOC entry 189 (class 1255 OID 16649)
-- Dependencies: 6
-- Name: dblink_close(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 190 (class 1255 OID 16650)
-- Dependencies: 6
-- Name: dblink_connect(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text) OWNER TO postgres;

--
-- TOC entry 191 (class 1255 OID 16651)
-- Dependencies: 6
-- Name: dblink_connect(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text, text) OWNER TO postgres;

--
-- TOC entry 776 (class 1255 OID 16652)
-- Dependencies: 6
-- Name: dblink_connect_u(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect_u(text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 16653)
-- Dependencies: 6
-- Name: dblink_connect_u(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect_u(text, text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text, text) OWNER TO postgres;

--
-- TOC entry 192 (class 1255 OID 16654)
-- Dependencies: 6
-- Name: dblink_current_query(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_current_query() RETURNS text
    LANGUAGE c
    AS '$libdir/dblink', 'dblink_current_query';


ALTER FUNCTION public.dblink_current_query() OWNER TO postgres;

--
-- TOC entry 193 (class 1255 OID 16655)
-- Dependencies: 6
-- Name: dblink_disconnect(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_disconnect() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect() OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 16656)
-- Dependencies: 6
-- Name: dblink_disconnect(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_disconnect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect(text) OWNER TO postgres;

--
-- TOC entry 195 (class 1255 OID 16657)
-- Dependencies: 6
-- Name: dblink_error_message(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_error_message(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_error_message';


ALTER FUNCTION public.dblink_error_message(text) OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 16658)
-- Dependencies: 6
-- Name: dblink_exec(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text) OWNER TO postgres;

--
-- TOC entry 197 (class 1255 OID 16659)
-- Dependencies: 6
-- Name: dblink_exec(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 198 (class 1255 OID 16660)
-- Dependencies: 6
-- Name: dblink_exec(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text) OWNER TO postgres;

--
-- TOC entry 199 (class 1255 OID 16661)
-- Dependencies: 6
-- Name: dblink_exec(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, boolean) OWNER TO postgres;

--
-- TOC entry 200 (class 1255 OID 16662)
-- Dependencies: 6
-- Name: dblink_fetch(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer) OWNER TO postgres;

--
-- TOC entry 201 (class 1255 OID 16663)
-- Dependencies: 6
-- Name: dblink_fetch(text, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer, boolean) OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 16664)
-- Dependencies: 6
-- Name: dblink_fetch(text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer) OWNER TO postgres;

--
-- TOC entry 203 (class 1255 OID 16665)
-- Dependencies: 6
-- Name: dblink_fetch(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer, boolean) OWNER TO postgres;

--
-- TOC entry 204 (class 1255 OID 16666)
-- Dependencies: 6
-- Name: dblink_get_connections(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_connections() RETURNS text[]
    LANGUAGE c
    AS '$libdir/dblink', 'dblink_get_connections';


ALTER FUNCTION public.dblink_get_connections() OWNER TO postgres;

--
-- TOC entry 205 (class 1255 OID 16667)
-- Dependencies: 1070 6
-- Name: dblink_get_pkey(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_pkey(text) RETURNS SETOF dblink_pkey_results
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_pkey';


ALTER FUNCTION public.dblink_get_pkey(text) OWNER TO postgres;

--
-- TOC entry 206 (class 1255 OID 16668)
-- Dependencies: 6
-- Name: dblink_get_result(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_result(text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_result';


ALTER FUNCTION public.dblink_get_result(text) OWNER TO postgres;

--
-- TOC entry 207 (class 1255 OID 16669)
-- Dependencies: 6
-- Name: dblink_get_result(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_result(text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_result';


ALTER FUNCTION public.dblink_get_result(text, boolean) OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 16670)
-- Dependencies: 6
-- Name: dblink_is_busy(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_is_busy(text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_is_busy';


ALTER FUNCTION public.dblink_is_busy(text) OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 16671)
-- Dependencies: 6
-- Name: dblink_open(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 16672)
-- Dependencies: 6
-- Name: dblink_open(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 16673)
-- Dependencies: 6
-- Name: dblink_open(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16674)
-- Dependencies: 6
-- Name: dblink_open(text, text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text, boolean) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16675)
-- Dependencies: 6
-- Name: dblink_send_query(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_send_query(text, text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_send_query';


ALTER FUNCTION public.dblink_send_query(text, text) OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16676)
-- Dependencies: 6
-- Name: dearmor(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dearmor(text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_dearmor';


ALTER FUNCTION public.dearmor(text) OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 16677)
-- Dependencies: 6
-- Name: decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION decrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt';


ALTER FUNCTION public.decrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16678)
-- Dependencies: 6
-- Name: decrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION decrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt_iv';


ALTER FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16679)
-- Dependencies: 1102 6
-- Name: defined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION defined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


ALTER FUNCTION public.defined(hstore, text) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16680)
-- Dependencies: 1102 6 1102
-- Name: delete(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete(hstore, text) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'delete';


ALTER FUNCTION public.delete(hstore, text) OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 16681)
-- Dependencies: 6
-- Name: difference(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION difference(text, text) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'difference';


ALTER FUNCTION public.difference(text, text) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 16682)
-- Dependencies: 6
-- Name: digest(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION digest(text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(text, text) OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 16683)
-- Dependencies: 6
-- Name: digest(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION digest(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(bytea, text) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 16684)
-- Dependencies: 6
-- Name: dmetaphone(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dmetaphone(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'dmetaphone';


ALTER FUNCTION public.dmetaphone(text) OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 16685)
-- Dependencies: 6
-- Name: dmetaphone_alt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dmetaphone_alt(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'dmetaphone_alt';


ALTER FUNCTION public.dmetaphone_alt(text) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 16686)
-- Dependencies: 6 1102
-- Name: each(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION each(hs hstore, OUT key text, OUT value text) RETURNS SETOF record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'each';


ALTER FUNCTION public.each(hs hstore, OUT key text, OUT value text) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 16687)
-- Dependencies: 1075 6 1067
-- Name: earth_box(earth, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth_box(earth, double precision) RETURNS cube
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT cube_enlarge($1, gc_to_sec($2), 3)$_$;


ALTER FUNCTION public.earth_box(earth, double precision) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16688)
-- Dependencies: 1075 6 1075
-- Name: earth_distance(earth, earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth_distance(earth, earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT sec_to_gc(cube_distance($1, $2))$_$;


ALTER FUNCTION public.earth_distance(earth, earth) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 16689)
-- Dependencies: 6
-- Name: encrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION encrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt';


ALTER FUNCTION public.encrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16690)
-- Dependencies: 6
-- Name: encrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION encrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt_iv';


ALTER FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 16691)
-- Dependencies: 6 1064
-- Name: eq(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eq(chkpass, text) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_eq';


ALTER FUNCTION public.eq(chkpass, text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2786 (class 1259 OID 16692)
-- Dependencies: 3127 3128 6
-- Name: examen; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE examen (
    id integer NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    tiempo integer,
    estado boolean DEFAULT false,
    programa_id integer DEFAULT 1,
    nombre text,
    descripcion text
);


ALTER TABLE public.examen OWNER TO root;

--
-- TOC entry 2787 (class 1259 OID 16700)
-- Dependencies: 3130 3131 6
-- Name: pregunta; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE pregunta (
    id integer NOT NULL,
    texto text NOT NULL,
    nivel integer,
    clave integer NOT NULL,
    tema text,
    tiempo integer,
    grupo_id integer,
    tipo_id integer DEFAULT 1 NOT NULL,
    profesor_cod integer DEFAULT 2009110122 NOT NULL,
    imagen_id integer,
    subarea_id integer NOT NULL,
    areatematica_id integer
);


ALTER TABLE public.pregunta OWNER TO root;

--
-- TOC entry 2788 (class 1259 OID 16708)
-- Dependencies: 6
-- Name: respuesta; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE respuesta (
    id integer NOT NULL,
    examen_id integer NOT NULL,
    estudiante_cod integer NOT NULL,
    pregunta_id integer NOT NULL,
    seleccion integer NOT NULL,
    acertada boolean
);


ALTER TABLE public.respuesta OWNER TO root;

--
-- TOC entry 2789 (class 1259 OID 16711)
-- Dependencies: 2909 6
-- Name: falso; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW falso AS
    SELECT pregunta.id, count(*) AS "FALSE" FROM examen, pregunta, respuesta WHERE ((((respuesta.pregunta_id = pregunta.id) AND (respuesta.acertada = false)) AND (examen.id = respuesta.examen_id)) AND (respuesta.examen_id = 52)) GROUP BY pregunta.id ORDER BY pregunta.id;


ALTER TABLE public.falso OWNER TO root;

--
-- TOC entry 231 (class 1255 OID 16715)
-- Dependencies: 1168 6 1229
-- Name: erradas(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION erradas(integer) RETURNS SETOF falso
    LANGUAGE plpgsql
    AS $_$
DECLARE
    r falso%rowtype;
    exam integer;
BEGIN
exam = $1;
  FOR r IN SELECT pregunta.id, count(*) AS "FALSE"
    FROM examen, pregunta, respuesta
    WHERE respuesta.pregunta_id = pregunta.id AND respuesta.acertada = FALSE AND examen.id = respuesta.examen_id AND respuesta.examen_id = exam
           GROUP BY pregunta.id
           ORDER BY pregunta.id
    LOOP
        
        RETURN NEXT r; 
    END LOOP;
    RETURN;
END
$_$;


ALTER FUNCTION public.erradas(integer) OWNER TO root;

--
-- TOC entry 232 (class 1255 OID 16716)
-- Dependencies: 6 1102
-- Name: exist(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exist(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


ALTER FUNCTION public.exist(hstore, text) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16717)
-- Dependencies: 6 1102
-- Name: fetchval(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fetchval(hstore, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'fetchval';


ALTER FUNCTION public.fetchval(hstore, text) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16718)
-- Dependencies: 6
-- Name: g_cube_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_compress';


ALTER FUNCTION public.g_cube_compress(internal) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16719)
-- Dependencies: 6 1067
-- Name: g_cube_consistent(internal, cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_consistent(internal, cube, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_consistent';


ALTER FUNCTION public.g_cube_consistent(internal, cube, integer) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16720)
-- Dependencies: 6
-- Name: g_cube_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_decompress';


ALTER FUNCTION public.g_cube_decompress(internal) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16721)
-- Dependencies: 6
-- Name: g_cube_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'g_cube_penalty';


ALTER FUNCTION public.g_cube_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16722)
-- Dependencies: 6
-- Name: g_cube_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_picksplit';


ALTER FUNCTION public.g_cube_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 16723)
-- Dependencies: 1067 6 1067
-- Name: g_cube_same(cube, cube, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_same(cube, cube, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_same';


ALTER FUNCTION public.g_cube_same(cube, cube, internal) OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 16724)
-- Dependencies: 6 1067
-- Name: g_cube_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_union(internal, internal) RETURNS cube
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_union';


ALTER FUNCTION public.g_cube_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 16725)
-- Dependencies: 6
-- Name: g_int_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_compress';


ALTER FUNCTION public.g_int_compress(internal) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 16726)
-- Dependencies: 6
-- Name: g_int_consistent(internal, integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_consistent(internal, integer[], integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_consistent';


ALTER FUNCTION public.g_int_consistent(internal, integer[], integer) OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 16727)
-- Dependencies: 6
-- Name: g_int_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_decompress';


ALTER FUNCTION public.g_int_decompress(internal) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16728)
-- Dependencies: 6
-- Name: g_int_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'g_int_penalty';


ALTER FUNCTION public.g_int_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16729)
-- Dependencies: 6
-- Name: g_int_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_picksplit';


ALTER FUNCTION public.g_int_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 16730)
-- Dependencies: 6
-- Name: g_int_same(integer[], integer[], internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_same(integer[], integer[], internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_same';


ALTER FUNCTION public.g_int_same(integer[], integer[], internal) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 16731)
-- Dependencies: 6
-- Name: g_int_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_union(internal, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_union';


ALTER FUNCTION public.g_int_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 16732)
-- Dependencies: 6
-- Name: g_intbig_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_compress';


ALTER FUNCTION public.g_intbig_compress(internal) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 16733)
-- Dependencies: 6
-- Name: g_intbig_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_consistent(internal, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_consistent';


ALTER FUNCTION public.g_intbig_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 16734)
-- Dependencies: 6
-- Name: g_intbig_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_decompress';


ALTER FUNCTION public.g_intbig_decompress(internal) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 16735)
-- Dependencies: 6
-- Name: g_intbig_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'g_intbig_penalty';


ALTER FUNCTION public.g_intbig_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 16736)
-- Dependencies: 6
-- Name: g_intbig_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_picksplit';


ALTER FUNCTION public.g_intbig_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 16737)
-- Dependencies: 6
-- Name: g_intbig_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_same';


ALTER FUNCTION public.g_intbig_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 16738)
-- Dependencies: 6
-- Name: g_intbig_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_union(internal, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_union';


ALTER FUNCTION public.g_intbig_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 16739)
-- Dependencies: 6
-- Name: gbt_bit_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_compress';


ALTER FUNCTION public.gbt_bit_compress(internal) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 16740)
-- Dependencies: 6
-- Name: gbt_bit_consistent(internal, bit, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_consistent(internal, bit, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_consistent';


ALTER FUNCTION public.gbt_bit_consistent(internal, bit, smallint) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 16741)
-- Dependencies: 6
-- Name: gbt_bit_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_bit_penalty';


ALTER FUNCTION public.gbt_bit_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 16742)
-- Dependencies: 6
-- Name: gbt_bit_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_picksplit';


ALTER FUNCTION public.gbt_bit_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 16743)
-- Dependencies: 6
-- Name: gbt_bit_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_same';


ALTER FUNCTION public.gbt_bit_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 16744)
-- Dependencies: 6 1093
-- Name: gbt_bit_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_union';


ALTER FUNCTION public.gbt_bit_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 16745)
-- Dependencies: 6
-- Name: gbt_bpchar_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bpchar_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bpchar_compress';


ALTER FUNCTION public.gbt_bpchar_compress(internal) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 16746)
-- Dependencies: 6
-- Name: gbt_bpchar_consistent(internal, character, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bpchar_consistent(internal, character, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bpchar_consistent';


ALTER FUNCTION public.gbt_bpchar_consistent(internal, character, smallint) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 16747)
-- Dependencies: 6
-- Name: gbt_bytea_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_compress';


ALTER FUNCTION public.gbt_bytea_compress(internal) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 16748)
-- Dependencies: 6
-- Name: gbt_bytea_consistent(internal, bytea, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_consistent(internal, bytea, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_consistent';


ALTER FUNCTION public.gbt_bytea_consistent(internal, bytea, smallint) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 16749)
-- Dependencies: 6
-- Name: gbt_bytea_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_bytea_penalty';


ALTER FUNCTION public.gbt_bytea_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 16750)
-- Dependencies: 6
-- Name: gbt_bytea_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_picksplit';


ALTER FUNCTION public.gbt_bytea_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 16751)
-- Dependencies: 6
-- Name: gbt_bytea_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_same';


ALTER FUNCTION public.gbt_bytea_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 16752)
-- Dependencies: 6 1093
-- Name: gbt_bytea_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_union';


ALTER FUNCTION public.gbt_bytea_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 16753)
-- Dependencies: 6
-- Name: gbt_cash_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_compress';


ALTER FUNCTION public.gbt_cash_compress(internal) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 16754)
-- Dependencies: 6
-- Name: gbt_cash_consistent(internal, money, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_consistent(internal, money, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_consistent';


ALTER FUNCTION public.gbt_cash_consistent(internal, money, smallint) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 16755)
-- Dependencies: 6
-- Name: gbt_cash_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_cash_penalty';


ALTER FUNCTION public.gbt_cash_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 16756)
-- Dependencies: 6
-- Name: gbt_cash_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_picksplit';


ALTER FUNCTION public.gbt_cash_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 16757)
-- Dependencies: 6
-- Name: gbt_cash_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_same';


ALTER FUNCTION public.gbt_cash_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 16758)
-- Dependencies: 6 1090
-- Name: gbt_cash_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_union';


ALTER FUNCTION public.gbt_cash_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 16759)
-- Dependencies: 6
-- Name: gbt_date_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_compress';


ALTER FUNCTION public.gbt_date_compress(internal) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 16760)
-- Dependencies: 6
-- Name: gbt_date_consistent(internal, date, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_consistent(internal, date, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_consistent';


ALTER FUNCTION public.gbt_date_consistent(internal, date, smallint) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 16761)
-- Dependencies: 6
-- Name: gbt_date_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_date_penalty';


ALTER FUNCTION public.gbt_date_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 16762)
-- Dependencies: 6
-- Name: gbt_date_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_picksplit';


ALTER FUNCTION public.gbt_date_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 16763)
-- Dependencies: 6
-- Name: gbt_date_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_same';


ALTER FUNCTION public.gbt_date_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 16764)
-- Dependencies: 1090 6
-- Name: gbt_date_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_union';


ALTER FUNCTION public.gbt_date_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 16765)
-- Dependencies: 6
-- Name: gbt_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_decompress';


ALTER FUNCTION public.gbt_decompress(internal) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 16766)
-- Dependencies: 6
-- Name: gbt_float4_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_compress';


ALTER FUNCTION public.gbt_float4_compress(internal) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 16767)
-- Dependencies: 6
-- Name: gbt_float4_consistent(internal, real, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_consistent(internal, real, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_consistent';


ALTER FUNCTION public.gbt_float4_consistent(internal, real, smallint) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 16768)
-- Dependencies: 6
-- Name: gbt_float4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_float4_penalty';


ALTER FUNCTION public.gbt_float4_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 16769)
-- Dependencies: 6
-- Name: gbt_float4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_picksplit';


ALTER FUNCTION public.gbt_float4_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 16770)
-- Dependencies: 6
-- Name: gbt_float4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_same';


ALTER FUNCTION public.gbt_float4_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 16771)
-- Dependencies: 1090 6
-- Name: gbt_float4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_union';


ALTER FUNCTION public.gbt_float4_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 16772)
-- Dependencies: 6
-- Name: gbt_float8_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_compress';


ALTER FUNCTION public.gbt_float8_compress(internal) OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 16773)
-- Dependencies: 6
-- Name: gbt_float8_consistent(internal, double precision, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_consistent(internal, double precision, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_consistent';


ALTER FUNCTION public.gbt_float8_consistent(internal, double precision, smallint) OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 16774)
-- Dependencies: 6
-- Name: gbt_float8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_float8_penalty';


ALTER FUNCTION public.gbt_float8_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 16775)
-- Dependencies: 6
-- Name: gbt_float8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_picksplit';


ALTER FUNCTION public.gbt_float8_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 16776)
-- Dependencies: 6
-- Name: gbt_float8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_same';


ALTER FUNCTION public.gbt_float8_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 16777)
-- Dependencies: 1081 6
-- Name: gbt_float8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_union';


ALTER FUNCTION public.gbt_float8_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 16778)
-- Dependencies: 6
-- Name: gbt_inet_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_compress';


ALTER FUNCTION public.gbt_inet_compress(internal) OWNER TO postgres;

--
-- TOC entry 295 (class 1255 OID 16779)
-- Dependencies: 6
-- Name: gbt_inet_consistent(internal, inet, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_consistent(internal, inet, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_consistent';


ALTER FUNCTION public.gbt_inet_consistent(internal, inet, smallint) OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 16780)
-- Dependencies: 6
-- Name: gbt_inet_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_inet_penalty';


ALTER FUNCTION public.gbt_inet_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 16781)
-- Dependencies: 6
-- Name: gbt_inet_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_picksplit';


ALTER FUNCTION public.gbt_inet_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 16782)
-- Dependencies: 6
-- Name: gbt_inet_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_same';


ALTER FUNCTION public.gbt_inet_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 16783)
-- Dependencies: 1081 6
-- Name: gbt_inet_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_union';


ALTER FUNCTION public.gbt_inet_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 16784)
-- Dependencies: 6
-- Name: gbt_int2_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_compress';


ALTER FUNCTION public.gbt_int2_compress(internal) OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 16785)
-- Dependencies: 6
-- Name: gbt_int2_consistent(internal, smallint, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_consistent(internal, smallint, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_consistent';


ALTER FUNCTION public.gbt_int2_consistent(internal, smallint, smallint) OWNER TO postgres;

--
-- TOC entry 302 (class 1255 OID 16786)
-- Dependencies: 6
-- Name: gbt_int2_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int2_penalty';


ALTER FUNCTION public.gbt_int2_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 16787)
-- Dependencies: 6
-- Name: gbt_int2_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_picksplit';


ALTER FUNCTION public.gbt_int2_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 16788)
-- Dependencies: 6
-- Name: gbt_int2_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_same';


ALTER FUNCTION public.gbt_int2_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 305 (class 1255 OID 16789)
-- Dependencies: 1087 6
-- Name: gbt_int2_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_union(bytea, internal) RETURNS gbtreekey4
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_union';


ALTER FUNCTION public.gbt_int2_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 306 (class 1255 OID 16790)
-- Dependencies: 6
-- Name: gbt_int4_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_compress';


ALTER FUNCTION public.gbt_int4_compress(internal) OWNER TO postgres;

--
-- TOC entry 307 (class 1255 OID 16791)
-- Dependencies: 6
-- Name: gbt_int4_consistent(internal, integer, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_consistent(internal, integer, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_consistent';


ALTER FUNCTION public.gbt_int4_consistent(internal, integer, smallint) OWNER TO postgres;

--
-- TOC entry 308 (class 1255 OID 16792)
-- Dependencies: 6
-- Name: gbt_int4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int4_penalty';


ALTER FUNCTION public.gbt_int4_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 309 (class 1255 OID 16793)
-- Dependencies: 6
-- Name: gbt_int4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_picksplit';


ALTER FUNCTION public.gbt_int4_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 310 (class 1255 OID 16794)
-- Dependencies: 6
-- Name: gbt_int4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_same';


ALTER FUNCTION public.gbt_int4_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 311 (class 1255 OID 16795)
-- Dependencies: 1090 6
-- Name: gbt_int4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_union';


ALTER FUNCTION public.gbt_int4_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 312 (class 1255 OID 16796)
-- Dependencies: 6
-- Name: gbt_int8_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_compress';


ALTER FUNCTION public.gbt_int8_compress(internal) OWNER TO postgres;

--
-- TOC entry 313 (class 1255 OID 16797)
-- Dependencies: 6
-- Name: gbt_int8_consistent(internal, bigint, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_consistent(internal, bigint, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_consistent';


ALTER FUNCTION public.gbt_int8_consistent(internal, bigint, smallint) OWNER TO postgres;

--
-- TOC entry 314 (class 1255 OID 16798)
-- Dependencies: 6
-- Name: gbt_int8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int8_penalty';


ALTER FUNCTION public.gbt_int8_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 315 (class 1255 OID 16799)
-- Dependencies: 6
-- Name: gbt_int8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_picksplit';


ALTER FUNCTION public.gbt_int8_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 316 (class 1255 OID 16800)
-- Dependencies: 6
-- Name: gbt_int8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_same';


ALTER FUNCTION public.gbt_int8_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 317 (class 1255 OID 16801)
-- Dependencies: 6 1081
-- Name: gbt_int8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_union';


ALTER FUNCTION public.gbt_int8_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 318 (class 1255 OID 16802)
-- Dependencies: 6
-- Name: gbt_intv_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_compress';


ALTER FUNCTION public.gbt_intv_compress(internal) OWNER TO postgres;

--
-- TOC entry 319 (class 1255 OID 16803)
-- Dependencies: 6
-- Name: gbt_intv_consistent(internal, interval, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_consistent(internal, interval, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_consistent';


ALTER FUNCTION public.gbt_intv_consistent(internal, interval, smallint) OWNER TO postgres;

--
-- TOC entry 320 (class 1255 OID 16804)
-- Dependencies: 6
-- Name: gbt_intv_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_decompress';


ALTER FUNCTION public.gbt_intv_decompress(internal) OWNER TO postgres;

--
-- TOC entry 321 (class 1255 OID 16805)
-- Dependencies: 6
-- Name: gbt_intv_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_intv_penalty';


ALTER FUNCTION public.gbt_intv_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 322 (class 1255 OID 16806)
-- Dependencies: 6
-- Name: gbt_intv_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_picksplit';


ALTER FUNCTION public.gbt_intv_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 323 (class 1255 OID 16807)
-- Dependencies: 6
-- Name: gbt_intv_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_same';


ALTER FUNCTION public.gbt_intv_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 324 (class 1255 OID 16808)
-- Dependencies: 1084 6
-- Name: gbt_intv_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_union(bytea, internal) RETURNS gbtreekey32
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_union';


ALTER FUNCTION public.gbt_intv_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 325 (class 1255 OID 16809)
-- Dependencies: 6
-- Name: gbt_macad_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_compress';


ALTER FUNCTION public.gbt_macad_compress(internal) OWNER TO postgres;

--
-- TOC entry 326 (class 1255 OID 16810)
-- Dependencies: 6
-- Name: gbt_macad_consistent(internal, macaddr, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_consistent(internal, macaddr, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_consistent';


ALTER FUNCTION public.gbt_macad_consistent(internal, macaddr, smallint) OWNER TO postgres;

--
-- TOC entry 327 (class 1255 OID 16811)
-- Dependencies: 6
-- Name: gbt_macad_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_macad_penalty';


ALTER FUNCTION public.gbt_macad_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 328 (class 1255 OID 16812)
-- Dependencies: 6
-- Name: gbt_macad_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_picksplit';


ALTER FUNCTION public.gbt_macad_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 329 (class 1255 OID 16813)
-- Dependencies: 6
-- Name: gbt_macad_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_same';


ALTER FUNCTION public.gbt_macad_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 330 (class 1255 OID 16814)
-- Dependencies: 1081 6
-- Name: gbt_macad_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_union';


ALTER FUNCTION public.gbt_macad_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 331 (class 1255 OID 16815)
-- Dependencies: 6
-- Name: gbt_numeric_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_compress';


ALTER FUNCTION public.gbt_numeric_compress(internal) OWNER TO postgres;

--
-- TOC entry 332 (class 1255 OID 16816)
-- Dependencies: 6
-- Name: gbt_numeric_consistent(internal, numeric, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_consistent(internal, numeric, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_consistent';


ALTER FUNCTION public.gbt_numeric_consistent(internal, numeric, smallint) OWNER TO postgres;

--
-- TOC entry 333 (class 1255 OID 16817)
-- Dependencies: 6
-- Name: gbt_numeric_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_numeric_penalty';


ALTER FUNCTION public.gbt_numeric_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 334 (class 1255 OID 16818)
-- Dependencies: 6
-- Name: gbt_numeric_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_picksplit';


ALTER FUNCTION public.gbt_numeric_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 335 (class 1255 OID 16819)
-- Dependencies: 6
-- Name: gbt_numeric_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_same';


ALTER FUNCTION public.gbt_numeric_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 336 (class 1255 OID 16820)
-- Dependencies: 6 1093
-- Name: gbt_numeric_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_union';


ALTER FUNCTION public.gbt_numeric_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 337 (class 1255 OID 16821)
-- Dependencies: 6
-- Name: gbt_oid_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_compress';


ALTER FUNCTION public.gbt_oid_compress(internal) OWNER TO postgres;

--
-- TOC entry 338 (class 1255 OID 16822)
-- Dependencies: 6
-- Name: gbt_oid_consistent(internal, oid, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_consistent(internal, oid, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_consistent';


ALTER FUNCTION public.gbt_oid_consistent(internal, oid, smallint) OWNER TO postgres;

--
-- TOC entry 339 (class 1255 OID 16823)
-- Dependencies: 6
-- Name: gbt_oid_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_oid_penalty';


ALTER FUNCTION public.gbt_oid_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 340 (class 1255 OID 16824)
-- Dependencies: 6
-- Name: gbt_oid_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_picksplit';


ALTER FUNCTION public.gbt_oid_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 341 (class 1255 OID 16825)
-- Dependencies: 6
-- Name: gbt_oid_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_same';


ALTER FUNCTION public.gbt_oid_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 342 (class 1255 OID 16826)
-- Dependencies: 6 1090
-- Name: gbt_oid_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_union';


ALTER FUNCTION public.gbt_oid_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 343 (class 1255 OID 16827)
-- Dependencies: 6
-- Name: gbt_text_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_compress';


ALTER FUNCTION public.gbt_text_compress(internal) OWNER TO postgres;

--
-- TOC entry 344 (class 1255 OID 16828)
-- Dependencies: 6
-- Name: gbt_text_consistent(internal, text, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_consistent(internal, text, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_consistent';


ALTER FUNCTION public.gbt_text_consistent(internal, text, smallint) OWNER TO postgres;

--
-- TOC entry 345 (class 1255 OID 16829)
-- Dependencies: 6
-- Name: gbt_text_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_text_penalty';


ALTER FUNCTION public.gbt_text_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 346 (class 1255 OID 16830)
-- Dependencies: 6
-- Name: gbt_text_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_picksplit';


ALTER FUNCTION public.gbt_text_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 347 (class 1255 OID 16831)
-- Dependencies: 6
-- Name: gbt_text_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_same';


ALTER FUNCTION public.gbt_text_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 348 (class 1255 OID 16832)
-- Dependencies: 6 1093
-- Name: gbt_text_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_union';


ALTER FUNCTION public.gbt_text_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 349 (class 1255 OID 16833)
-- Dependencies: 6
-- Name: gbt_time_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_compress';


ALTER FUNCTION public.gbt_time_compress(internal) OWNER TO postgres;

--
-- TOC entry 350 (class 1255 OID 16834)
-- Dependencies: 6
-- Name: gbt_time_consistent(internal, time without time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_consistent(internal, time without time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_consistent';


ALTER FUNCTION public.gbt_time_consistent(internal, time without time zone, smallint) OWNER TO postgres;

--
-- TOC entry 351 (class 1255 OID 16835)
-- Dependencies: 6
-- Name: gbt_time_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_time_penalty';


ALTER FUNCTION public.gbt_time_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 352 (class 1255 OID 16836)
-- Dependencies: 6
-- Name: gbt_time_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_picksplit';


ALTER FUNCTION public.gbt_time_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 353 (class 1255 OID 16837)
-- Dependencies: 6
-- Name: gbt_time_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_same';


ALTER FUNCTION public.gbt_time_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 354 (class 1255 OID 16838)
-- Dependencies: 1081 6
-- Name: gbt_time_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_union';


ALTER FUNCTION public.gbt_time_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 355 (class 1255 OID 16839)
-- Dependencies: 6
-- Name: gbt_timetz_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_timetz_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_timetz_compress';


ALTER FUNCTION public.gbt_timetz_compress(internal) OWNER TO postgres;

--
-- TOC entry 356 (class 1255 OID 16840)
-- Dependencies: 6
-- Name: gbt_timetz_consistent(internal, time with time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_timetz_consistent(internal, time with time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_timetz_consistent';


ALTER FUNCTION public.gbt_timetz_consistent(internal, time with time zone, smallint) OWNER TO postgres;

--
-- TOC entry 357 (class 1255 OID 16841)
-- Dependencies: 6
-- Name: gbt_ts_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_compress';


ALTER FUNCTION public.gbt_ts_compress(internal) OWNER TO postgres;

--
-- TOC entry 358 (class 1255 OID 16842)
-- Dependencies: 6
-- Name: gbt_ts_consistent(internal, timestamp without time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_consistent(internal, timestamp without time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_consistent';


ALTER FUNCTION public.gbt_ts_consistent(internal, timestamp without time zone, smallint) OWNER TO postgres;

--
-- TOC entry 359 (class 1255 OID 16843)
-- Dependencies: 6
-- Name: gbt_ts_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_ts_penalty';


ALTER FUNCTION public.gbt_ts_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 360 (class 1255 OID 16844)
-- Dependencies: 6
-- Name: gbt_ts_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_picksplit';


ALTER FUNCTION public.gbt_ts_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 361 (class 1255 OID 16845)
-- Dependencies: 6
-- Name: gbt_ts_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_same';


ALTER FUNCTION public.gbt_ts_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 362 (class 1255 OID 16846)
-- Dependencies: 1081 6
-- Name: gbt_ts_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_union';


ALTER FUNCTION public.gbt_ts_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 363 (class 1255 OID 16847)
-- Dependencies: 6
-- Name: gbt_tstz_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_tstz_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_tstz_compress';


ALTER FUNCTION public.gbt_tstz_compress(internal) OWNER TO postgres;

--
-- TOC entry 364 (class 1255 OID 16848)
-- Dependencies: 6
-- Name: gbt_tstz_consistent(internal, timestamp with time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_tstz_consistent(internal, timestamp with time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_tstz_consistent';


ALTER FUNCTION public.gbt_tstz_consistent(internal, timestamp with time zone, smallint) OWNER TO postgres;

--
-- TOC entry 365 (class 1255 OID 16849)
-- Dependencies: 6
-- Name: gbt_var_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_var_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_var_decompress';


ALTER FUNCTION public.gbt_var_decompress(internal) OWNER TO postgres;

--
-- TOC entry 366 (class 1255 OID 16850)
-- Dependencies: 6
-- Name: gc_to_sec(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gc_to_sec(double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/earth() > pi() THEN 2*earth() ELSE 2*earth()*sin($1/(2*earth())) END$_$;


ALTER FUNCTION public.gc_to_sec(double precision) OWNER TO postgres;

--
-- TOC entry 367 (class 1255 OID 16851)
-- Dependencies: 6
-- Name: gen_random_bytes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_random_bytes(integer) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_random_bytes';


ALTER FUNCTION public.gen_random_bytes(integer) OWNER TO postgres;

--
-- TOC entry 368 (class 1255 OID 16852)
-- Dependencies: 6
-- Name: gen_salt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_salt(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt';


ALTER FUNCTION public.gen_salt(text) OWNER TO postgres;

--
-- TOC entry 369 (class 1255 OID 16853)
-- Dependencies: 6
-- Name: gen_salt(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_salt(text, integer) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt_rounds';


ALTER FUNCTION public.gen_salt(text, integer) OWNER TO postgres;

--
-- TOC entry 370 (class 1255 OID 16854)
-- Dependencies: 6
-- Name: geo_distance(point, point); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geo_distance(point, point) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/earthdistance', 'geo_distance';


ALTER FUNCTION public.geo_distance(point, point) OWNER TO postgres;

--
-- TOC entry 371 (class 1255 OID 16855)
-- Dependencies: 6
-- Name: get_raw_page(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_raw_page(text, integer) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'get_raw_page';


ALTER FUNCTION public.get_raw_page(text, integer) OWNER TO postgres;

--
-- TOC entry 372 (class 1255 OID 16856)
-- Dependencies: 6
-- Name: get_timetravel(name); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_timetravel(name) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/timetravel', 'get_timetravel';


ALTER FUNCTION public.get_timetravel(name) OWNER TO postgres;

--
-- TOC entry 373 (class 1255 OID 16857)
-- Dependencies: 6
-- Name: ghstore_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_compress';


ALTER FUNCTION public.ghstore_compress(internal) OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 16858)
-- Dependencies: 6
-- Name: ghstore_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_consistent(internal, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_consistent';


ALTER FUNCTION public.ghstore_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 16859)
-- Dependencies: 6
-- Name: ghstore_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_decompress';


ALTER FUNCTION public.ghstore_decompress(internal) OWNER TO postgres;

--
-- TOC entry 376 (class 1255 OID 16860)
-- Dependencies: 6
-- Name: ghstore_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_penalty';


ALTER FUNCTION public.ghstore_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 377 (class 1255 OID 16861)
-- Dependencies: 6
-- Name: ghstore_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_picksplit';


ALTER FUNCTION public.ghstore_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 378 (class 1255 OID 16862)
-- Dependencies: 6
-- Name: ghstore_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_same';


ALTER FUNCTION public.ghstore_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 379 (class 1255 OID 16863)
-- Dependencies: 6
-- Name: ghstore_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_union(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_union';


ALTER FUNCTION public.ghstore_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 16864)
-- Dependencies: 6
-- Name: gin_consistent_hstore(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_consistent_hstore(internal, smallint, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_consistent_hstore';


ALTER FUNCTION public.gin_consistent_hstore(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 381 (class 1255 OID 16865)
-- Dependencies: 6
-- Name: gin_extract_hstore(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_extract_hstore';


ALTER FUNCTION public.gin_extract_hstore(internal, internal) OWNER TO postgres;

--
-- TOC entry 382 (class 1255 OID 16866)
-- Dependencies: 6
-- Name: gin_extract_hstore_query(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore_query(internal, internal, smallint) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_extract_hstore_query';


ALTER FUNCTION public.gin_extract_hstore_query(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 383 (class 1255 OID 16867)
-- Dependencies: 6
-- Name: gin_extract_trgm(text, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_trgm(text, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_extract_trgm';


ALTER FUNCTION public.gin_extract_trgm(text, internal) OWNER TO postgres;

--
-- TOC entry 384 (class 1255 OID 16868)
-- Dependencies: 6
-- Name: gin_extract_trgm(text, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_trgm(text, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_extract_trgm';


ALTER FUNCTION public.gin_extract_trgm(text, internal, internal) OWNER TO postgres;

--
-- TOC entry 385 (class 1255 OID 16869)
-- Dependencies: 6
-- Name: gin_trgm_consistent(internal, internal, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_trgm_consistent(internal, internal, text) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_trgm_consistent';


ALTER FUNCTION public.gin_trgm_consistent(internal, internal, text) OWNER TO postgres;

--
-- TOC entry 386 (class 1255 OID 16870)
-- Dependencies: 6
-- Name: ginint4_consistent(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_consistent(internal, smallint, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'ginint4_consistent';


ALTER FUNCTION public.ginint4_consistent(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 387 (class 1255 OID 16871)
-- Dependencies: 6
-- Name: ginint4_queryextract(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_queryextract(internal, internal, smallint) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'ginint4_queryextract';


ALTER FUNCTION public.ginint4_queryextract(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 388 (class 1255 OID 16872)
-- Dependencies: 6
-- Name: gseg_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_compress';


ALTER FUNCTION public.gseg_compress(internal) OWNER TO postgres;

--
-- TOC entry 389 (class 1255 OID 16873)
-- Dependencies: 6 1144
-- Name: gseg_consistent(internal, seg, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_consistent(internal, seg, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_consistent';


ALTER FUNCTION public.gseg_consistent(internal, seg, integer) OWNER TO postgres;

--
-- TOC entry 390 (class 1255 OID 16874)
-- Dependencies: 6
-- Name: gseg_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_decompress';


ALTER FUNCTION public.gseg_decompress(internal) OWNER TO postgres;

--
-- TOC entry 391 (class 1255 OID 16875)
-- Dependencies: 6
-- Name: gseg_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'gseg_penalty';


ALTER FUNCTION public.gseg_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 392 (class 1255 OID 16876)
-- Dependencies: 6
-- Name: gseg_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_picksplit';


ALTER FUNCTION public.gseg_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 393 (class 1255 OID 16877)
-- Dependencies: 1144 6 1144
-- Name: gseg_same(seg, seg, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_same(seg, seg, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_same';


ALTER FUNCTION public.gseg_same(seg, seg, internal) OWNER TO postgres;

--
-- TOC entry 394 (class 1255 OID 16878)
-- Dependencies: 1144 6
-- Name: gseg_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_union(internal, internal) RETURNS seg
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_union';


ALTER FUNCTION public.gseg_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 395 (class 1255 OID 16879)
-- Dependencies: 6
-- Name: gtrgm_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_compress';


ALTER FUNCTION public.gtrgm_compress(internal) OWNER TO postgres;

--
-- TOC entry 396 (class 1255 OID 16880)
-- Dependencies: 6 1099
-- Name: gtrgm_consistent(gtrgm, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_consistent(gtrgm, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_consistent';


ALTER FUNCTION public.gtrgm_consistent(gtrgm, internal, integer) OWNER TO postgres;

--
-- TOC entry 397 (class 1255 OID 16881)
-- Dependencies: 6
-- Name: gtrgm_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_decompress';


ALTER FUNCTION public.gtrgm_decompress(internal) OWNER TO postgres;

--
-- TOC entry 398 (class 1255 OID 16882)
-- Dependencies: 6
-- Name: gtrgm_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'gtrgm_penalty';


ALTER FUNCTION public.gtrgm_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 16883)
-- Dependencies: 6
-- Name: gtrgm_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_picksplit';


ALTER FUNCTION public.gtrgm_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 400 (class 1255 OID 16884)
-- Dependencies: 6 1099 1099
-- Name: gtrgm_same(gtrgm, gtrgm, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_same(gtrgm, gtrgm, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_same';


ALTER FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal) OWNER TO postgres;

--
-- TOC entry 401 (class 1255 OID 16885)
-- Dependencies: 6
-- Name: gtrgm_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_union(bytea, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_union';


ALTER FUNCTION public.gtrgm_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 402 (class 1255 OID 16886)
-- Dependencies: 6 1072
-- Name: hashean13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashean13(ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashean13(ean13) OWNER TO postgres;

--
-- TOC entry 403 (class 1255 OID 16887)
-- Dependencies: 1108 6
-- Name: hashisbn(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashisbn(isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashisbn(isbn) OWNER TO postgres;

--
-- TOC entry 404 (class 1255 OID 16888)
-- Dependencies: 1111 6
-- Name: hashisbn13(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashisbn13(isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashisbn13(isbn13) OWNER TO postgres;

--
-- TOC entry 405 (class 1255 OID 16889)
-- Dependencies: 1114 6
-- Name: hashismn(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashismn(ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashismn(ismn) OWNER TO postgres;

--
-- TOC entry 406 (class 1255 OID 16890)
-- Dependencies: 1117 6
-- Name: hashismn13(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashismn13(ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashismn13(ismn13) OWNER TO postgres;

--
-- TOC entry 407 (class 1255 OID 16891)
-- Dependencies: 6 1120
-- Name: hashissn(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashissn(issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashissn(issn) OWNER TO postgres;

--
-- TOC entry 408 (class 1255 OID 16892)
-- Dependencies: 1123 6
-- Name: hashissn13(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashissn13(issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashissn13(issn13) OWNER TO postgres;

--
-- TOC entry 409 (class 1255 OID 16893)
-- Dependencies: 1155 6
-- Name: hashupc(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashupc(upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashupc(upc) OWNER TO postgres;

--
-- TOC entry 410 (class 1255 OID 16894)
-- Dependencies: 6
-- Name: heap_page_items(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'heap_page_items';


ALTER FUNCTION public.heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) OWNER TO postgres;

--
-- TOC entry 411 (class 1255 OID 16895)
-- Dependencies: 6
-- Name: hmac(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hmac(text, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(text, text, text) OWNER TO postgres;

--
-- TOC entry 412 (class 1255 OID 16896)
-- Dependencies: 6
-- Name: hmac(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hmac(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 413 (class 1255 OID 16897)
-- Dependencies: 1102 6 1102 1102
-- Name: hs_concat(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_concat(hstore, hstore) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_concat';


ALTER FUNCTION public.hs_concat(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 414 (class 1255 OID 16898)
-- Dependencies: 1102 6 1102
-- Name: hs_contained(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contained(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contained';


ALTER FUNCTION public.hs_contained(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 415 (class 1255 OID 16899)
-- Dependencies: 1102 1102 6
-- Name: hs_contains(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contains(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contains';


ALTER FUNCTION public.hs_contains(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 416 (class 1255 OID 16900)
-- Dependencies: 6
-- Name: icount(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION icount(integer[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'icount';


ALTER FUNCTION public.icount(integer[]) OWNER TO postgres;

--
-- TOC entry 417 (class 1255 OID 16901)
-- Dependencies: 6
-- Name: idx(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION idx(integer[], integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'idx';


ALTER FUNCTION public.idx(integer[], integer) OWNER TO postgres;

--
-- TOC entry 418 (class 1255 OID 16902)
-- Dependencies: 6 1130 1130
-- Name: index(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION index(ltree, ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_index';


ALTER FUNCTION public.index(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 419 (class 1255 OID 16903)
-- Dependencies: 6 1130 1130
-- Name: index(ltree, ltree, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION index(ltree, ltree, integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_index';


ALTER FUNCTION public.index(ltree, ltree, integer) OWNER TO postgres;

--
-- TOC entry 420 (class 1255 OID 16904)
-- Dependencies: 6
-- Name: insert_username(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_username() RETURNS trigger
    LANGUAGE c
    AS '$libdir/insert_username', 'insert_username';


ALTER FUNCTION public.insert_username() OWNER TO postgres;

--
-- TOC entry 421 (class 1255 OID 16905)
-- Dependencies: 6
-- Name: intarray_del_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_del_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_del_elem';


ALTER FUNCTION public.intarray_del_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 422 (class 1255 OID 16906)
-- Dependencies: 6
-- Name: intarray_push_array(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_array(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_array';


ALTER FUNCTION public.intarray_push_array(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 423 (class 1255 OID 16907)
-- Dependencies: 6
-- Name: intarray_push_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_elem';


ALTER FUNCTION public.intarray_push_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 424 (class 1255 OID 16908)
-- Dependencies: 6
-- Name: intset(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset(integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset';


ALTER FUNCTION public.intset(integer) OWNER TO postgres;

--
-- TOC entry 425 (class 1255 OID 16909)
-- Dependencies: 6
-- Name: intset_subtract(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_subtract(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_subtract';


ALTER FUNCTION public.intset_subtract(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 426 (class 1255 OID 16910)
-- Dependencies: 6
-- Name: intset_union_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_union_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_union_elem';


ALTER FUNCTION public.intset_union_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 427 (class 1255 OID 16911)
-- Dependencies: 1072 6
-- Name: is_valid(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ean13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ean13) OWNER TO postgres;

--
-- TOC entry 428 (class 1255 OID 16912)
-- Dependencies: 1111 6
-- Name: is_valid(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(isbn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(isbn13) OWNER TO postgres;

--
-- TOC entry 429 (class 1255 OID 16913)
-- Dependencies: 6 1117
-- Name: is_valid(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ismn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ismn13) OWNER TO postgres;

--
-- TOC entry 430 (class 1255 OID 16914)
-- Dependencies: 6 1123
-- Name: is_valid(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(issn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(issn13) OWNER TO postgres;

--
-- TOC entry 431 (class 1255 OID 16915)
-- Dependencies: 1108 6
-- Name: is_valid(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(isbn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(isbn) OWNER TO postgres;

--
-- TOC entry 432 (class 1255 OID 16916)
-- Dependencies: 1114 6
-- Name: is_valid(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ismn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ismn) OWNER TO postgres;

--
-- TOC entry 433 (class 1255 OID 16917)
-- Dependencies: 6 1120
-- Name: is_valid(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(issn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(issn) OWNER TO postgres;

--
-- TOC entry 434 (class 1255 OID 16918)
-- Dependencies: 1155 6
-- Name: is_valid(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(upc) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(upc) OWNER TO postgres;

--
-- TOC entry 435 (class 1255 OID 16919)
-- Dependencies: 6 1108 1072
-- Name: isbn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn(ean13) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_cast_from_ean13';


ALTER FUNCTION public.isbn(ean13) OWNER TO postgres;

--
-- TOC entry 436 (class 1255 OID 16920)
-- Dependencies: 1111 1072 6
-- Name: isbn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn13(ean13) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_cast_from_ean13';


ALTER FUNCTION public.isbn13(ean13) OWNER TO postgres;

--
-- TOC entry 437 (class 1255 OID 16921)
-- Dependencies: 6 1102
-- Name: isdefined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isdefined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


ALTER FUNCTION public.isdefined(hstore, text) OWNER TO postgres;

--
-- TOC entry 438 (class 1255 OID 16922)
-- Dependencies: 1102 6
-- Name: isexists(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isexists(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


ALTER FUNCTION public.isexists(hstore, text) OWNER TO postgres;

--
-- TOC entry 439 (class 1255 OID 16923)
-- Dependencies: 6 1114 1072
-- Name: ismn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn(ean13) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_cast_from_ean13';


ALTER FUNCTION public.ismn(ean13) OWNER TO postgres;

--
-- TOC entry 440 (class 1255 OID 16924)
-- Dependencies: 6 1117 1072
-- Name: ismn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn13(ean13) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_cast_from_ean13';


ALTER FUNCTION public.ismn13(ean13) OWNER TO postgres;

--
-- TOC entry 441 (class 1255 OID 16925)
-- Dependencies: 6
-- Name: isn_weak(boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_weak(boolean) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'accept_weak_input';


ALTER FUNCTION public.isn_weak(boolean) OWNER TO postgres;

--
-- TOC entry 442 (class 1255 OID 16926)
-- Dependencies: 6
-- Name: isn_weak(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_weak() RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'weak_input_status';


ALTER FUNCTION public.isn_weak() OWNER TO postgres;

--
-- TOC entry 443 (class 1255 OID 16927)
-- Dependencies: 6 1072 1072
-- Name: isneq(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 16928)
-- Dependencies: 6 1072 1111
-- Name: isneq(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 445 (class 1255 OID 16929)
-- Dependencies: 6 1072 1117
-- Name: isneq(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 446 (class 1255 OID 16930)
-- Dependencies: 6 1072 1123
-- Name: isneq(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 16931)
-- Dependencies: 6 1072 1108
-- Name: isneq(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 16932)
-- Dependencies: 6 1072 1114
-- Name: isneq(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 16933)
-- Dependencies: 1120 1072 6
-- Name: isneq(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, issn) OWNER TO postgres;

--
-- TOC entry 450 (class 1255 OID 16934)
-- Dependencies: 6 1155 1072
-- Name: isneq(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, upc) OWNER TO postgres;

--
-- TOC entry 451 (class 1255 OID 16935)
-- Dependencies: 6 1111 1111
-- Name: isneq(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 16936)
-- Dependencies: 1108 1111 6
-- Name: isneq(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 16937)
-- Dependencies: 6 1072 1111
-- Name: isneq(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 16938)
-- Dependencies: 1108 1108 6
-- Name: isneq(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 16939)
-- Dependencies: 1111 6 1108
-- Name: isneq(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 16940)
-- Dependencies: 6 1072 1108
-- Name: isneq(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 16941)
-- Dependencies: 6 1117 1117
-- Name: isneq(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 16942)
-- Dependencies: 6 1117 1114
-- Name: isneq(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 16943)
-- Dependencies: 1117 1072 6
-- Name: isneq(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 460 (class 1255 OID 16944)
-- Dependencies: 1114 1114 6
-- Name: isneq(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 16945)
-- Dependencies: 6 1117 1114
-- Name: isneq(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 462 (class 1255 OID 16946)
-- Dependencies: 1114 1072 6
-- Name: isneq(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 16947)
-- Dependencies: 1123 6 1123
-- Name: isneq(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 16948)
-- Dependencies: 1120 1123 6
-- Name: isneq(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, issn) OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 16949)
-- Dependencies: 1123 1072 6
-- Name: isneq(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 16950)
-- Dependencies: 1120 1120 6
-- Name: isneq(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, issn) OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 16951)
-- Dependencies: 1120 6 1123
-- Name: isneq(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, issn13) OWNER TO postgres;

--
-- TOC entry 468 (class 1255 OID 16952)
-- Dependencies: 1072 6 1120
-- Name: isneq(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, ean13) OWNER TO postgres;

--
-- TOC entry 469 (class 1255 OID 16953)
-- Dependencies: 6 1155 1155
-- Name: isneq(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(upc, upc) OWNER TO postgres;

--
-- TOC entry 470 (class 1255 OID 16954)
-- Dependencies: 1072 6 1155
-- Name: isneq(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(upc, ean13) OWNER TO postgres;

--
-- TOC entry 471 (class 1255 OID 16955)
-- Dependencies: 1072 1072 6
-- Name: isnge(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 472 (class 1255 OID 16956)
-- Dependencies: 6 1072 1111
-- Name: isnge(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 16957)
-- Dependencies: 6 1072 1117
-- Name: isnge(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 16958)
-- Dependencies: 1123 6 1072
-- Name: isnge(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 16959)
-- Dependencies: 6 1072 1108
-- Name: isnge(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 16960)
-- Dependencies: 6 1072 1114
-- Name: isnge(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 16961)
-- Dependencies: 6 1072 1120
-- Name: isnge(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, issn) OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 16962)
-- Dependencies: 6 1072 1155
-- Name: isnge(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, upc) OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 16963)
-- Dependencies: 6 1111 1111
-- Name: isnge(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 16964)
-- Dependencies: 6 1111 1108
-- Name: isnge(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 16965)
-- Dependencies: 6 1111 1072
-- Name: isnge(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 16966)
-- Dependencies: 6 1108 1108
-- Name: isnge(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 16967)
-- Dependencies: 6 1108 1111
-- Name: isnge(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 16968)
-- Dependencies: 6 1108 1072
-- Name: isnge(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 16969)
-- Dependencies: 6 1117 1117
-- Name: isnge(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 16970)
-- Dependencies: 6 1117 1114
-- Name: isnge(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 16971)
-- Dependencies: 6 1117 1072
-- Name: isnge(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 16972)
-- Dependencies: 6 1114 1114
-- Name: isnge(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 16973)
-- Dependencies: 6 1114 1117
-- Name: isnge(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 16974)
-- Dependencies: 6 1114 1072
-- Name: isnge(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 16975)
-- Dependencies: 6 1123 1123
-- Name: isnge(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 16976)
-- Dependencies: 6 1123 1120
-- Name: isnge(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, issn) OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 16977)
-- Dependencies: 6 1123 1072
-- Name: isnge(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 494 (class 1255 OID 16978)
-- Dependencies: 6 1120 1120
-- Name: isnge(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, issn) OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 16979)
-- Dependencies: 6 1120 1123
-- Name: isnge(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, issn13) OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 16980)
-- Dependencies: 6 1120 1072
-- Name: isnge(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, ean13) OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 16981)
-- Dependencies: 6 1155 1155
-- Name: isnge(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(upc, upc) OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 16982)
-- Dependencies: 6 1155 1072
-- Name: isnge(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(upc, ean13) OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 16983)
-- Dependencies: 6 1072 1072
-- Name: isngt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 16984)
-- Dependencies: 1111 1072 6
-- Name: isngt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 16985)
-- Dependencies: 1072 1117 6
-- Name: isngt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 16986)
-- Dependencies: 1072 1123 6
-- Name: isngt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 16987)
-- Dependencies: 6 1108 1072
-- Name: isngt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 16988)
-- Dependencies: 6 1114 1072
-- Name: isngt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 505 (class 1255 OID 16989)
-- Dependencies: 6 1120 1072
-- Name: isngt(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, issn) OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 16990)
-- Dependencies: 1155 1072 6
-- Name: isngt(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, upc) OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 16991)
-- Dependencies: 6 1111 1111
-- Name: isngt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 16992)
-- Dependencies: 1108 1111 6
-- Name: isngt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 509 (class 1255 OID 16993)
-- Dependencies: 1072 1111 6
-- Name: isngt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 16994)
-- Dependencies: 6 1108 1108
-- Name: isngt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 16995)
-- Dependencies: 6 1111 1108
-- Name: isngt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 512 (class 1255 OID 16996)
-- Dependencies: 6 1108 1072
-- Name: isngt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 16997)
-- Dependencies: 6 1117 1117
-- Name: isngt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 16998)
-- Dependencies: 1114 1117 6
-- Name: isngt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 16999)
-- Dependencies: 6 1072 1117
-- Name: isngt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 17000)
-- Dependencies: 6 1114 1114
-- Name: isngt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 17001)
-- Dependencies: 6 1114 1117
-- Name: isngt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 17002)
-- Dependencies: 6 1114 1072
-- Name: isngt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 17003)
-- Dependencies: 6 1123 1123
-- Name: isngt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 17004)
-- Dependencies: 6 1123 1120
-- Name: isngt(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, issn) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 17005)
-- Dependencies: 6 1123 1072
-- Name: isngt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 17006)
-- Dependencies: 6 1120 1120
-- Name: isngt(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, issn) OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 17007)
-- Dependencies: 6 1120 1123
-- Name: isngt(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, issn13) OWNER TO postgres;

--
-- TOC entry 524 (class 1255 OID 17008)
-- Dependencies: 6 1120 1072
-- Name: isngt(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, ean13) OWNER TO postgres;

--
-- TOC entry 525 (class 1255 OID 17009)
-- Dependencies: 6 1155 1155
-- Name: isngt(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(upc, upc) OWNER TO postgres;

--
-- TOC entry 526 (class 1255 OID 17010)
-- Dependencies: 6 1155 1072
-- Name: isngt(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(upc, ean13) OWNER TO postgres;

--
-- TOC entry 527 (class 1255 OID 17011)
-- Dependencies: 6 1072 1072
-- Name: isnle(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 528 (class 1255 OID 17012)
-- Dependencies: 6 1111 1072
-- Name: isnle(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 529 (class 1255 OID 17013)
-- Dependencies: 6 1072 1117
-- Name: isnle(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 530 (class 1255 OID 17014)
-- Dependencies: 6 1123 1072
-- Name: isnle(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 531 (class 1255 OID 17015)
-- Dependencies: 1108 1072 6
-- Name: isnle(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 532 (class 1255 OID 17016)
-- Dependencies: 6 1114 1072
-- Name: isnle(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 533 (class 1255 OID 17017)
-- Dependencies: 1072 1120 6
-- Name: isnle(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, issn) OWNER TO postgres;

--
-- TOC entry 534 (class 1255 OID 17018)
-- Dependencies: 1155 6 1072
-- Name: isnle(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, upc) OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 17019)
-- Dependencies: 1111 6 1111
-- Name: isnle(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 17020)
-- Dependencies: 1111 6 1108
-- Name: isnle(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 537 (class 1255 OID 17021)
-- Dependencies: 1072 6 1111
-- Name: isnle(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 538 (class 1255 OID 17022)
-- Dependencies: 1108 1108 6
-- Name: isnle(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 539 (class 1255 OID 17023)
-- Dependencies: 6 1111 1108
-- Name: isnle(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 540 (class 1255 OID 17024)
-- Dependencies: 1072 1108 6
-- Name: isnle(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 541 (class 1255 OID 17025)
-- Dependencies: 1117 6 1117
-- Name: isnle(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 542 (class 1255 OID 17026)
-- Dependencies: 6 1117 1114
-- Name: isnle(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 17027)
-- Dependencies: 1117 6 1072
-- Name: isnle(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 544 (class 1255 OID 17028)
-- Dependencies: 1114 1114 6
-- Name: isnle(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 17029)
-- Dependencies: 6 1114 1117
-- Name: isnle(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 546 (class 1255 OID 17030)
-- Dependencies: 6 1114 1072
-- Name: isnle(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 547 (class 1255 OID 17031)
-- Dependencies: 1123 6 1123
-- Name: isnle(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 17032)
-- Dependencies: 6 1123 1120
-- Name: isnle(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, issn) OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 17033)
-- Dependencies: 1123 6 1072
-- Name: isnle(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 550 (class 1255 OID 17034)
-- Dependencies: 6 1120 1120
-- Name: isnle(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, issn) OWNER TO postgres;

--
-- TOC entry 551 (class 1255 OID 17035)
-- Dependencies: 6 1123 1120
-- Name: isnle(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, issn13) OWNER TO postgres;

--
-- TOC entry 552 (class 1255 OID 17036)
-- Dependencies: 1072 1120 6
-- Name: isnle(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, ean13) OWNER TO postgres;

--
-- TOC entry 553 (class 1255 OID 17037)
-- Dependencies: 6 1155 1155
-- Name: isnle(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(upc, upc) OWNER TO postgres;

--
-- TOC entry 554 (class 1255 OID 17038)
-- Dependencies: 1155 6 1072
-- Name: isnle(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(upc, ean13) OWNER TO postgres;

--
-- TOC entry 555 (class 1255 OID 17039)
-- Dependencies: 1072 1072 6
-- Name: isnlt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 556 (class 1255 OID 17040)
-- Dependencies: 6 1072 1111
-- Name: isnlt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 557 (class 1255 OID 17041)
-- Dependencies: 1117 1072 6
-- Name: isnlt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 558 (class 1255 OID 17042)
-- Dependencies: 1123 1072 6
-- Name: isnlt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 559 (class 1255 OID 17043)
-- Dependencies: 1108 1072 6
-- Name: isnlt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 560 (class 1255 OID 17044)
-- Dependencies: 6 1072 1114
-- Name: isnlt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 561 (class 1255 OID 17045)
-- Dependencies: 6 1072 1120
-- Name: isnlt(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, issn) OWNER TO postgres;

--
-- TOC entry 562 (class 1255 OID 17046)
-- Dependencies: 6 1155 1072
-- Name: isnlt(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, upc) OWNER TO postgres;

--
-- TOC entry 563 (class 1255 OID 17047)
-- Dependencies: 1111 1111 6
-- Name: isnlt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 564 (class 1255 OID 17048)
-- Dependencies: 1108 6 1111
-- Name: isnlt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 565 (class 1255 OID 17049)
-- Dependencies: 1072 6 1111
-- Name: isnlt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 566 (class 1255 OID 17050)
-- Dependencies: 6 1108 1108
-- Name: isnlt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 567 (class 1255 OID 17051)
-- Dependencies: 1111 1108 6
-- Name: isnlt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 568 (class 1255 OID 17052)
-- Dependencies: 1072 1108 6
-- Name: isnlt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 569 (class 1255 OID 17053)
-- Dependencies: 1117 6 1117
-- Name: isnlt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 570 (class 1255 OID 17054)
-- Dependencies: 6 1114 1117
-- Name: isnlt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 571 (class 1255 OID 17055)
-- Dependencies: 1072 1117 6
-- Name: isnlt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 572 (class 1255 OID 17056)
-- Dependencies: 6 1114 1114
-- Name: isnlt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 573 (class 1255 OID 17057)
-- Dependencies: 1117 1114 6
-- Name: isnlt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 574 (class 1255 OID 17058)
-- Dependencies: 6 1114 1072
-- Name: isnlt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 575 (class 1255 OID 17059)
-- Dependencies: 6 1123 1123
-- Name: isnlt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 576 (class 1255 OID 17060)
-- Dependencies: 1123 6 1120
-- Name: isnlt(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, issn) OWNER TO postgres;

--
-- TOC entry 577 (class 1255 OID 17061)
-- Dependencies: 1072 1123 6
-- Name: isnlt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 578 (class 1255 OID 17062)
-- Dependencies: 6 1120 1120
-- Name: isnlt(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, issn) OWNER TO postgres;

--
-- TOC entry 579 (class 1255 OID 17063)
-- Dependencies: 6 1123 1120
-- Name: isnlt(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, issn13) OWNER TO postgres;

--
-- TOC entry 580 (class 1255 OID 17064)
-- Dependencies: 1072 1120 6
-- Name: isnlt(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, ean13) OWNER TO postgres;

--
-- TOC entry 581 (class 1255 OID 17065)
-- Dependencies: 1155 6 1155
-- Name: isnlt(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(upc, upc) OWNER TO postgres;

--
-- TOC entry 582 (class 1255 OID 17066)
-- Dependencies: 1072 6 1155
-- Name: isnlt(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(upc, ean13) OWNER TO postgres;

--
-- TOC entry 583 (class 1255 OID 17067)
-- Dependencies: 6 1072 1072
-- Name: isnne(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 584 (class 1255 OID 17068)
-- Dependencies: 6 1111 1072
-- Name: isnne(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 585 (class 1255 OID 17069)
-- Dependencies: 1072 1117 6
-- Name: isnne(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 586 (class 1255 OID 17070)
-- Dependencies: 6 1123 1072
-- Name: isnne(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 587 (class 1255 OID 17071)
-- Dependencies: 6 1072 1108
-- Name: isnne(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 588 (class 1255 OID 17072)
-- Dependencies: 6 1072 1114
-- Name: isnne(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 589 (class 1255 OID 17073)
-- Dependencies: 6 1072 1120
-- Name: isnne(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, issn) OWNER TO postgres;

--
-- TOC entry 590 (class 1255 OID 17074)
-- Dependencies: 6 1072 1155
-- Name: isnne(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, upc) OWNER TO postgres;

--
-- TOC entry 591 (class 1255 OID 17075)
-- Dependencies: 1111 1111 6
-- Name: isnne(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 592 (class 1255 OID 17076)
-- Dependencies: 1108 1111 6
-- Name: isnne(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 593 (class 1255 OID 17077)
-- Dependencies: 1072 6 1111
-- Name: isnne(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 594 (class 1255 OID 17078)
-- Dependencies: 1108 1108 6
-- Name: isnne(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 595 (class 1255 OID 17079)
-- Dependencies: 1111 6 1108
-- Name: isnne(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 596 (class 1255 OID 17080)
-- Dependencies: 1072 1108 6
-- Name: isnne(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 597 (class 1255 OID 17081)
-- Dependencies: 1117 6 1117
-- Name: isnne(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 598 (class 1255 OID 17082)
-- Dependencies: 1114 1117 6
-- Name: isnne(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 599 (class 1255 OID 17083)
-- Dependencies: 1117 6 1072
-- Name: isnne(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 600 (class 1255 OID 17084)
-- Dependencies: 6 1114 1114
-- Name: isnne(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 601 (class 1255 OID 17085)
-- Dependencies: 1114 6 1117
-- Name: isnne(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 602 (class 1255 OID 17086)
-- Dependencies: 6 1114 1072
-- Name: isnne(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 603 (class 1255 OID 17087)
-- Dependencies: 1123 6 1123
-- Name: isnne(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 604 (class 1255 OID 17088)
-- Dependencies: 1120 6 1123
-- Name: isnne(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, issn) OWNER TO postgres;

--
-- TOC entry 605 (class 1255 OID 17089)
-- Dependencies: 6 1072 1123
-- Name: isnne(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 606 (class 1255 OID 17090)
-- Dependencies: 6 1120 1120
-- Name: isnne(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, issn) OWNER TO postgres;

--
-- TOC entry 607 (class 1255 OID 17091)
-- Dependencies: 6 1123 1120
-- Name: isnne(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, issn13) OWNER TO postgres;

--
-- TOC entry 608 (class 1255 OID 17092)
-- Dependencies: 6 1120 1072
-- Name: isnne(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, ean13) OWNER TO postgres;

--
-- TOC entry 609 (class 1255 OID 17093)
-- Dependencies: 6 1155 1155
-- Name: isnne(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(upc, upc) OWNER TO postgres;

--
-- TOC entry 610 (class 1255 OID 17094)
-- Dependencies: 6 1155 1072
-- Name: isnne(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(upc, ean13) OWNER TO postgres;

--
-- TOC entry 611 (class 1255 OID 17095)
-- Dependencies: 6 1120 1072
-- Name: issn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn(ean13) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_cast_from_ean13';


ALTER FUNCTION public.issn(ean13) OWNER TO postgres;

--
-- TOC entry 612 (class 1255 OID 17096)
-- Dependencies: 1072 1123 6
-- Name: issn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn13(ean13) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_cast_from_ean13';


ALTER FUNCTION public.issn13(ean13) OWNER TO postgres;

--
-- TOC entry 613 (class 1255 OID 17097)
-- Dependencies: 1075 6
-- Name: latitude(earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION latitude(earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN cube_ll_coord($1, 3)/earth() < -1 THEN -90::float8 WHEN cube_ll_coord($1, 3)/earth() > 1 THEN 90::float8 ELSE degrees(asin(cube_ll_coord($1, 3)/earth())) END$_$;


ALTER FUNCTION public.latitude(earth) OWNER TO postgres;

--
-- TOC entry 614 (class 1255 OID 17098)
-- Dependencies: 1130 6 1132
-- Name: lca(ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree[]) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lca';


ALTER FUNCTION public.lca(ltree[]) OWNER TO postgres;

--
-- TOC entry 615 (class 1255 OID 17099)
-- Dependencies: 1130 1130 1130 6
-- Name: lca(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 616 (class 1255 OID 17100)
-- Dependencies: 1130 1130 1130 1130 6
-- Name: lca(ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 617 (class 1255 OID 17101)
-- Dependencies: 1130 6 1130 1130 1130 1130
-- Name: lca(ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 618 (class 1255 OID 17102)
-- Dependencies: 6 1130 1130 1130 1130 1130 1130
-- Name: lca(ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 619 (class 1255 OID 17103)
-- Dependencies: 1130 6 1130 1130 1130 1130 1130 1130
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 620 (class 1255 OID 17104)
-- Dependencies: 1130 1130 1130 1130 1130 6 1130 1130 1130
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 621 (class 1255 OID 17105)
-- Dependencies: 1130 1130 1130 1130 1130 1130 1130 6 1130 1130
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 622 (class 1255 OID 17106)
-- Dependencies: 6
-- Name: levenshtein(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION levenshtein(text, text) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'levenshtein';


ALTER FUNCTION public.levenshtein(text, text) OWNER TO postgres;

--
-- TOC entry 623 (class 1255 OID 17107)
-- Dependencies: 6 1075
-- Name: ll_to_earth(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ll_to_earth(double precision, double precision) RETURNS earth
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT cube(cube(cube(earth()*cos(radians($1))*cos(radians($2))),earth()*cos(radians($1))*sin(radians($2))),earth()*sin(radians($1)))::earth$_$;


ALTER FUNCTION public.ll_to_earth(double precision, double precision) OWNER TO postgres;

--
-- TOC entry 624 (class 1255 OID 17108)
-- Dependencies: 6 1229
-- Name: llena_acertada(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION llena_acertada() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

rpta integer;


BEGIN

SELECT clave INTO rpta FROM pregunta WHERE pregunta.id = NEW.pregunta_id;

IF rpta = NEW.seleccion THEN

UPDATE respuesta
   SET acertada='TRUE'
WHERE id = NEW.id;

RETURN NULL;

ELSE

UPDATE respuesta
   SET acertada='FALSE'
WHERE id = NEW.id;

RETURN NULL;
END IF;

RETURN NEW;
END$$;


ALTER FUNCTION public.llena_acertada() OWNER TO root;

--
-- TOC entry 625 (class 1255 OID 17109)
-- Dependencies: 6
-- Name: lo_manage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_manage() RETURNS trigger
    LANGUAGE c
    AS '$libdir/lo', 'lo_manage';


ALTER FUNCTION public.lo_manage() OWNER TO postgres;

--
-- TOC entry 626 (class 1255 OID 17110)
-- Dependencies: 1126 6
-- Name: lo_oid(lo); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_oid(lo) RETURNS oid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT $1::pg_catalog.oid$_$;


ALTER FUNCTION public.lo_oid(lo) OWNER TO postgres;

--
-- TOC entry 627 (class 1255 OID 17111)
-- Dependencies: 6 1075
-- Name: longitude(earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION longitude(earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT degrees(atan2(cube_ll_coord($1, 2), cube_ll_coord($1, 1)))$_$;


ALTER FUNCTION public.longitude(earth) OWNER TO postgres;

--
-- TOC entry 628 (class 1255 OID 17112)
-- Dependencies: 1130 1129 6
-- Name: lt_q_regex(ltree, lquery[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lt_q_regex(ltree, lquery[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lt_q_regex';


ALTER FUNCTION public.lt_q_regex(ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 629 (class 1255 OID 17113)
-- Dependencies: 1130 6 1129
-- Name: lt_q_rregex(lquery[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lt_q_rregex(lquery[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lt_q_rregex';


ALTER FUNCTION public.lt_q_rregex(lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 630 (class 1255 OID 17114)
-- Dependencies: 1127 1130 6
-- Name: ltq_regex(ltree, lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltq_regex(ltree, lquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltq_regex';


ALTER FUNCTION public.ltq_regex(ltree, lquery) OWNER TO postgres;

--
-- TOC entry 631 (class 1255 OID 17115)
-- Dependencies: 1127 6 1130
-- Name: ltq_rregex(lquery, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltq_rregex(lquery, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltq_rregex';


ALTER FUNCTION public.ltq_rregex(lquery, ltree) OWNER TO postgres;

--
-- TOC entry 632 (class 1255 OID 17116)
-- Dependencies: 6 1130
-- Name: ltree2text(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree2text(ltree) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree2text';


ALTER FUNCTION public.ltree2text(ltree) OWNER TO postgres;

--
-- TOC entry 633 (class 1255 OID 17117)
-- Dependencies: 1130 6 1130 1130
-- Name: ltree_addltree(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_addltree(ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_addltree';


ALTER FUNCTION public.ltree_addltree(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 634 (class 1255 OID 17118)
-- Dependencies: 6 1130 1130
-- Name: ltree_addtext(ltree, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_addtext(ltree, text) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_addtext';


ALTER FUNCTION public.ltree_addtext(ltree, text) OWNER TO postgres;

--
-- TOC entry 635 (class 1255 OID 17119)
-- Dependencies: 1130 1130 6
-- Name: ltree_cmp(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_cmp(ltree, ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_cmp';


ALTER FUNCTION public.ltree_cmp(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 636 (class 1255 OID 17120)
-- Dependencies: 6
-- Name: ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_compress';


ALTER FUNCTION public.ltree_compress(internal) OWNER TO postgres;

--
-- TOC entry 637 (class 1255 OID 17121)
-- Dependencies: 6
-- Name: ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_consistent(internal, internal, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_consistent';


ALTER FUNCTION public.ltree_consistent(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 638 (class 1255 OID 17122)
-- Dependencies: 6
-- Name: ltree_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_decompress';


ALTER FUNCTION public.ltree_decompress(internal) OWNER TO postgres;

--
-- TOC entry 639 (class 1255 OID 17123)
-- Dependencies: 1130 1130 6
-- Name: ltree_eq(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_eq(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_eq';


ALTER FUNCTION public.ltree_eq(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 640 (class 1255 OID 17124)
-- Dependencies: 6 1130 1130
-- Name: ltree_ge(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_ge(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_ge';


ALTER FUNCTION public.ltree_ge(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 641 (class 1255 OID 17125)
-- Dependencies: 1130 6 1130
-- Name: ltree_gt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gt(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_gt';


ALTER FUNCTION public.ltree_gt(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 642 (class 1255 OID 17126)
-- Dependencies: 6 1130 1130
-- Name: ltree_isparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_isparent(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_isparent';


ALTER FUNCTION public.ltree_isparent(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 643 (class 1255 OID 17127)
-- Dependencies: 6 1130 1130
-- Name: ltree_le(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_le(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_le';


ALTER FUNCTION public.ltree_le(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 644 (class 1255 OID 17128)
-- Dependencies: 6 1130 1130
-- Name: ltree_lt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_lt(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_lt';


ALTER FUNCTION public.ltree_lt(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 645 (class 1255 OID 17129)
-- Dependencies: 6 1130 1130
-- Name: ltree_ne(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_ne(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_ne';


ALTER FUNCTION public.ltree_ne(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 646 (class 1255 OID 17130)
-- Dependencies: 6
-- Name: ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_penalty';


ALTER FUNCTION public.ltree_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 647 (class 1255 OID 17131)
-- Dependencies: 6
-- Name: ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_picksplit';


ALTER FUNCTION public.ltree_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 648 (class 1255 OID 17132)
-- Dependencies: 6 1130 1130
-- Name: ltree_risparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_risparent(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_risparent';


ALTER FUNCTION public.ltree_risparent(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 649 (class 1255 OID 17133)
-- Dependencies: 6
-- Name: ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_same';


ALTER FUNCTION public.ltree_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 650 (class 1255 OID 17134)
-- Dependencies: 6 1130 1130
-- Name: ltree_textadd(text, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_textadd(text, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_textadd';


ALTER FUNCTION public.ltree_textadd(text, ltree) OWNER TO postgres;

--
-- TOC entry 651 (class 1255 OID 17135)
-- Dependencies: 6
-- Name: ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_union(internal, internal) RETURNS integer
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_union';


ALTER FUNCTION public.ltree_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 652 (class 1255 OID 17136)
-- Dependencies: 6
-- Name: ltreeparentsel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltreeparentsel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltreeparentsel';


ALTER FUNCTION public.ltreeparentsel(internal, oid, internal, integer) OWNER TO postgres;

--
-- TOC entry 653 (class 1255 OID 17137)
-- Dependencies: 6 1130 1136
-- Name: ltxtq_exec(ltree, ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_exec(ltree, ltxtquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltxtq_exec';


ALTER FUNCTION public.ltxtq_exec(ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 654 (class 1255 OID 17138)
-- Dependencies: 6 1136 1130
-- Name: ltxtq_rexec(ltxtquery, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_rexec(ltxtquery, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltxtq_rexec';


ALTER FUNCTION public.ltxtq_rexec(ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 655 (class 1255 OID 17139)
-- Dependencies: 6 1072 1072
-- Name: make_valid(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ean13) RETURNS ean13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ean13) OWNER TO postgres;

--
-- TOC entry 656 (class 1255 OID 17140)
-- Dependencies: 6 1111 1111
-- Name: make_valid(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(isbn13) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(isbn13) OWNER TO postgres;

--
-- TOC entry 657 (class 1255 OID 17141)
-- Dependencies: 6 1117 1117
-- Name: make_valid(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ismn13) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ismn13) OWNER TO postgres;

--
-- TOC entry 658 (class 1255 OID 17142)
-- Dependencies: 6 1123 1123
-- Name: make_valid(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(issn13) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(issn13) OWNER TO postgres;

--
-- TOC entry 659 (class 1255 OID 17143)
-- Dependencies: 6 1108 1108
-- Name: make_valid(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(isbn) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(isbn) OWNER TO postgres;

--
-- TOC entry 660 (class 1255 OID 17144)
-- Dependencies: 1114 6 1114
-- Name: make_valid(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ismn) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ismn) OWNER TO postgres;

--
-- TOC entry 661 (class 1255 OID 17145)
-- Dependencies: 6 1120 1120
-- Name: make_valid(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(issn) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(issn) OWNER TO postgres;

--
-- TOC entry 662 (class 1255 OID 17146)
-- Dependencies: 6 1155 1155
-- Name: make_valid(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(upc) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(upc) OWNER TO postgres;

--
-- TOC entry 663 (class 1255 OID 17147)
-- Dependencies: 6
-- Name: metaphone(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION metaphone(text, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'metaphone';


ALTER FUNCTION public.metaphone(text, integer) OWNER TO postgres;

--
-- TOC entry 664 (class 1255 OID 17148)
-- Dependencies: 6
-- Name: moddatetime(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION moddatetime() RETURNS trigger
    LANGUAGE c
    AS '$libdir/moddatetime', 'moddatetime';


ALTER FUNCTION public.moddatetime() OWNER TO postgres;

--
-- TOC entry 665 (class 1255 OID 17149)
-- Dependencies: 6 1064
-- Name: ne(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ne(chkpass, text) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_ne';


ALTER FUNCTION public.ne(chkpass, text) OWNER TO postgres;

--
-- TOC entry 666 (class 1255 OID 17150)
-- Dependencies: 6 1130
-- Name: nlevel(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nlevel(ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'nlevel';


ALTER FUNCTION public.nlevel(ltree) OWNER TO postgres;

--
-- TOC entry 667 (class 1255 OID 17151)
-- Dependencies: 6 1229
-- Name: no_repeat(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION no_repeat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
CODIGO RECORD;
BEGIN

SELECT cod INTO CODIGO FROM profesor WHERE cod = NEW.cod;

IF NOT FOUND THEN 
RETURN NEW;
ELSE
RAISE EXCEPTION 'CODIGO EXISTENTE!';
END IF;  



END$$;


ALTER FUNCTION public.no_repeat() OWNER TO root;

--
-- TOC entry 668 (class 1255 OID 17152)
-- Dependencies: 6 1229
-- Name: no_repeat2(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION no_repeat2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE 
CODIGO RECORD;
BEGIN

SELECT cod INTO CODIGO FROM estudiante WHERE cod = NEW.cod;

IF NOT FOUND THEN 
RETURN NEW;
ELSE
RAISE EXCEPTION 'CODIGO EXISTENTE!';
END IF;  



END$$;


ALTER FUNCTION public.no_repeat2() OWNER TO root;

--
-- TOC entry 669 (class 1255 OID 17153)
-- Dependencies: 6
-- Name: normal_rand(integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION normal_rand(integer, double precision, double precision) RETURNS SETOF double precision
    LANGUAGE c STRICT
    AS '$libdir/tablefunc', 'normal_rand';


ALTER FUNCTION public.normal_rand(integer, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 672 (class 1255 OID 17154)
-- Dependencies: 6
-- Name: page_header(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'page_header';


ALTER FUNCTION public.page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) OWNER TO postgres;

--
-- TOC entry 775 (class 1255 OID 17155)
-- Dependencies: 6
-- Name: pg_buffercache_pages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pg_buffercache_pages() RETURNS SETOF record
    LANGUAGE c
    AS '$libdir/pg_buffercache', 'pg_buffercache_pages';


ALTER FUNCTION public.pg_buffercache_pages() OWNER TO postgres;

--
-- TOC entry 673 (class 1255 OID 17156)
-- Dependencies: 6
-- Name: pg_relpages(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pg_relpages(text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pg_relpages';


ALTER FUNCTION public.pg_relpages(text) OWNER TO postgres;

--
-- TOC entry 674 (class 1255 OID 17157)
-- Dependencies: 6
-- Name: pgp_key_id(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_key_id(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_key_id_w';


ALTER FUNCTION public.pgp_key_id(bytea) OWNER TO postgres;

--
-- TOC entry 675 (class 1255 OID 17158)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 676 (class 1255 OID 17159)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 677 (class 1255 OID 17160)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) OWNER TO postgres;

--
-- TOC entry 678 (class 1255 OID 17161)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 679 (class 1255 OID 17162)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 680 (class 1255 OID 17163)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) OWNER TO postgres;

--
-- TOC entry 681 (class 1255 OID 17164)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea) OWNER TO postgres;

--
-- TOC entry 682 (class 1255 OID 17165)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea, text) OWNER TO postgres;

--
-- TOC entry 683 (class 1255 OID 17166)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 684 (class 1255 OID 17167)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 685 (class 1255 OID 17168)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text) OWNER TO postgres;

--
-- TOC entry 686 (class 1255 OID 17169)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 687 (class 1255 OID 17170)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) OWNER TO postgres;

--
-- TOC entry 688 (class 1255 OID 17171)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 689 (class 1255 OID 17172)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt(text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text) OWNER TO postgres;

--
-- TOC entry 690 (class 1255 OID 17173)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt(text, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text, text) OWNER TO postgres;

--
-- TOC entry 691 (class 1255 OID 17174)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) OWNER TO postgres;

--
-- TOC entry 692 (class 1255 OID 17175)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 693 (class 1255 OID 17176)
-- Dependencies: 6
-- Name: pgstatindex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstatindex(relname text, OUT version integer, OUT tree_level integer, OUT index_size integer, OUT root_block_no integer, OUT internal_pages integer, OUT leaf_pages integer, OUT empty_pages integer, OUT deleted_pages integer, OUT avg_leaf_density double precision, OUT leaf_fragmentation double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstatindex';


ALTER FUNCTION public.pgstatindex(relname text, OUT version integer, OUT tree_level integer, OUT index_size integer, OUT root_block_no integer, OUT internal_pages integer, OUT leaf_pages integer, OUT empty_pages integer, OUT deleted_pages integer, OUT avg_leaf_density double precision, OUT leaf_fragmentation double precision) OWNER TO postgres;

--
-- TOC entry 694 (class 1255 OID 17177)
-- Dependencies: 6
-- Name: pgstattuple(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstattuple(relname text, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstattuple';


ALTER FUNCTION public.pgstattuple(relname text, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) OWNER TO postgres;

--
-- TOC entry 695 (class 1255 OID 17178)
-- Dependencies: 6
-- Name: pgstattuple(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstattuple(reloid oid, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstattuplebyid';


ALTER FUNCTION public.pgstattuple(reloid oid, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) OWNER TO postgres;

--
-- TOC entry 696 (class 1255 OID 17179)
-- Dependencies: 6 1153
-- Name: pldbg_get_target_info(text, "char"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_target_info(signature text, targettype "char") RETURNS targetinfo
    LANGUAGE c STRICT
    AS '$libdir/targetinfo', 'pldbg_get_target_info';


ALTER FUNCTION public.pldbg_get_target_info(signature text, targettype "char") OWNER TO postgres;

--
-- TOC entry 697 (class 1255 OID 17180)
-- Dependencies: 6
-- Name: plpgsql_oid_debug(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_oid_debug(functionoid oid) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/plugins/plugin_debugger', 'plpgsql_oid_debug';


ALTER FUNCTION public.plpgsql_oid_debug(functionoid oid) OWNER TO postgres;

--
-- TOC entry 698 (class 1255 OID 17181)
-- Dependencies: 6 1141
-- Name: querytree(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION querytree(query_int) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'querytree';


ALTER FUNCTION public.querytree(query_int) OWNER TO postgres;

--
-- TOC entry 699 (class 1255 OID 17182)
-- Dependencies: 6 1064
-- Name: raw(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION raw(chkpass) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_rout';


ALTER FUNCTION public.raw(chkpass) OWNER TO postgres;

--
-- TOC entry 700 (class 1255 OID 17183)
-- Dependencies: 6 1141
-- Name: rboolop(query_int, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rboolop(query_int, integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'rboolop';


ALTER FUNCTION public.rboolop(query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 3266 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION rboolop(query_int, integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION rboolop(query_int, integer[]) IS 'boolean operation with array';


--
-- TOC entry 701 (class 1255 OID 17184)
-- Dependencies: 6
-- Name: sec_to_gc(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sec_to_gc(double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/(2*earth()) > 1 THEN pi()*earth() ELSE 2*earth()*asin($1/(2*earth())) END$_$;


ALTER FUNCTION public.sec_to_gc(double precision) OWNER TO postgres;

--
-- TOC entry 702 (class 1255 OID 17185)
-- Dependencies: 6 1144 1144
-- Name: seg_cmp(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_cmp(seg, seg) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_cmp';


ALTER FUNCTION public.seg_cmp(seg, seg) OWNER TO postgres;

--
-- TOC entry 3267 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION seg_cmp(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_cmp(seg, seg) IS 'btree comparison function';


--
-- TOC entry 670 (class 1255 OID 17186)
-- Dependencies: 6 1144 1144
-- Name: seg_contained(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_contained(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_contained';


ALTER FUNCTION public.seg_contained(seg, seg) OWNER TO postgres;

--
-- TOC entry 3268 (class 0 OID 0)
-- Dependencies: 670
-- Name: FUNCTION seg_contained(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_contained(seg, seg) IS 'contained in';


--
-- TOC entry 671 (class 1255 OID 17187)
-- Dependencies: 6 1144 1144
-- Name: seg_contains(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_contains(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_contains';


ALTER FUNCTION public.seg_contains(seg, seg) OWNER TO postgres;

--
-- TOC entry 3269 (class 0 OID 0)
-- Dependencies: 671
-- Name: FUNCTION seg_contains(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_contains(seg, seg) IS 'contains';


--
-- TOC entry 703 (class 1255 OID 17188)
-- Dependencies: 1144 6 1144
-- Name: seg_different(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_different(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_different';


ALTER FUNCTION public.seg_different(seg, seg) OWNER TO postgres;

--
-- TOC entry 3270 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION seg_different(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_different(seg, seg) IS 'different';


--
-- TOC entry 704 (class 1255 OID 17189)
-- Dependencies: 6 1144 1144
-- Name: seg_ge(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_ge(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_ge';


ALTER FUNCTION public.seg_ge(seg, seg) OWNER TO postgres;

--
-- TOC entry 3271 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION seg_ge(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_ge(seg, seg) IS 'greater than or equal';


--
-- TOC entry 705 (class 1255 OID 17190)
-- Dependencies: 1144 6 1144
-- Name: seg_gt(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_gt(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_gt';


ALTER FUNCTION public.seg_gt(seg, seg) OWNER TO postgres;

--
-- TOC entry 3272 (class 0 OID 0)
-- Dependencies: 705
-- Name: FUNCTION seg_gt(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_gt(seg, seg) IS 'greater than';


--
-- TOC entry 706 (class 1255 OID 17191)
-- Dependencies: 1144 6 1144 1144
-- Name: seg_inter(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_inter(seg, seg) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_inter';


ALTER FUNCTION public.seg_inter(seg, seg) OWNER TO postgres;

--
-- TOC entry 707 (class 1255 OID 17192)
-- Dependencies: 1144 1144 6
-- Name: seg_le(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_le(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_le';


ALTER FUNCTION public.seg_le(seg, seg) OWNER TO postgres;

--
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 707
-- Name: FUNCTION seg_le(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_le(seg, seg) IS 'less than or equal';


--
-- TOC entry 708 (class 1255 OID 17193)
-- Dependencies: 6 1144 1144
-- Name: seg_left(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_left(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_left';


ALTER FUNCTION public.seg_left(seg, seg) OWNER TO postgres;

--
-- TOC entry 3274 (class 0 OID 0)
-- Dependencies: 708
-- Name: FUNCTION seg_left(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_left(seg, seg) IS 'is left of';


--
-- TOC entry 709 (class 1255 OID 17194)
-- Dependencies: 6 1144
-- Name: seg_lower(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_lower(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_lower';


ALTER FUNCTION public.seg_lower(seg) OWNER TO postgres;

--
-- TOC entry 710 (class 1255 OID 17195)
-- Dependencies: 6 1144 1144
-- Name: seg_lt(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_lt(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_lt';


ALTER FUNCTION public.seg_lt(seg, seg) OWNER TO postgres;

--
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION seg_lt(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_lt(seg, seg) IS 'less than';


--
-- TOC entry 711 (class 1255 OID 17196)
-- Dependencies: 6 1144 1144
-- Name: seg_over_left(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_over_left(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_over_left';


ALTER FUNCTION public.seg_over_left(seg, seg) OWNER TO postgres;

--
-- TOC entry 3276 (class 0 OID 0)
-- Dependencies: 711
-- Name: FUNCTION seg_over_left(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_over_left(seg, seg) IS 'overlaps or is left of';


--
-- TOC entry 712 (class 1255 OID 17197)
-- Dependencies: 1144 6 1144
-- Name: seg_over_right(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_over_right(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_over_right';


ALTER FUNCTION public.seg_over_right(seg, seg) OWNER TO postgres;

--
-- TOC entry 3277 (class 0 OID 0)
-- Dependencies: 712
-- Name: FUNCTION seg_over_right(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_over_right(seg, seg) IS 'overlaps or is right of';


--
-- TOC entry 713 (class 1255 OID 17198)
-- Dependencies: 1144 6 1144
-- Name: seg_overlap(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_overlap(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_overlap';


ALTER FUNCTION public.seg_overlap(seg, seg) OWNER TO postgres;

--
-- TOC entry 3278 (class 0 OID 0)
-- Dependencies: 713
-- Name: FUNCTION seg_overlap(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_overlap(seg, seg) IS 'overlaps';


--
-- TOC entry 714 (class 1255 OID 17199)
-- Dependencies: 1144 6 1144
-- Name: seg_right(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_right(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_right';


ALTER FUNCTION public.seg_right(seg, seg) OWNER TO postgres;

--
-- TOC entry 3279 (class 0 OID 0)
-- Dependencies: 714
-- Name: FUNCTION seg_right(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_right(seg, seg) IS 'is right of';


--
-- TOC entry 715 (class 1255 OID 17200)
-- Dependencies: 1144 1144 6
-- Name: seg_same(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_same(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_same';


ALTER FUNCTION public.seg_same(seg, seg) OWNER TO postgres;

--
-- TOC entry 3280 (class 0 OID 0)
-- Dependencies: 715
-- Name: FUNCTION seg_same(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_same(seg, seg) IS 'same as';


--
-- TOC entry 716 (class 1255 OID 17201)
-- Dependencies: 1144 6
-- Name: seg_size(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_size(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_size';


ALTER FUNCTION public.seg_size(seg) OWNER TO postgres;

--
-- TOC entry 717 (class 1255 OID 17202)
-- Dependencies: 1144 6 1144 1144
-- Name: seg_union(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_union(seg, seg) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_union';


ALTER FUNCTION public.seg_union(seg, seg) OWNER TO postgres;

--
-- TOC entry 718 (class 1255 OID 17203)
-- Dependencies: 6 1144
-- Name: seg_upper(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_upper(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_upper';


ALTER FUNCTION public.seg_upper(seg) OWNER TO postgres;

--
-- TOC entry 719 (class 1255 OID 17204)
-- Dependencies: 6
-- Name: set_limit(real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_limit(real) RETURNS real
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'set_limit';


ALTER FUNCTION public.set_limit(real) OWNER TO postgres;

--
-- TOC entry 720 (class 1255 OID 17205)
-- Dependencies: 6
-- Name: set_timetravel(name, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_timetravel(name, integer) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/timetravel', 'set_timetravel';


ALTER FUNCTION public.set_timetravel(name, integer) OWNER TO postgres;

--
-- TOC entry 721 (class 1255 OID 17206)
-- Dependencies: 6
-- Name: show_limit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_limit() RETURNS real
    LANGUAGE c STABLE STRICT
    AS '$libdir/pg_trgm', 'show_limit';


ALTER FUNCTION public.show_limit() OWNER TO postgres;

--
-- TOC entry 722 (class 1255 OID 17207)
-- Dependencies: 6
-- Name: show_trgm(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_trgm(text) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'show_trgm';


ALTER FUNCTION public.show_trgm(text) OWNER TO postgres;

--
-- TOC entry 723 (class 1255 OID 17208)
-- Dependencies: 6
-- Name: similarity(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION similarity(text, text) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'similarity';


ALTER FUNCTION public.similarity(text, text) OWNER TO postgres;

--
-- TOC entry 724 (class 1255 OID 17209)
-- Dependencies: 6
-- Name: similarity_op(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION similarity_op(text, text) RETURNS boolean
    LANGUAGE c STABLE STRICT
    AS '$libdir/pg_trgm', 'similarity_op';


ALTER FUNCTION public.similarity_op(text, text) OWNER TO postgres;

--
-- TOC entry 725 (class 1255 OID 17210)
-- Dependencies: 1102 6
-- Name: skeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION skeys(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'skeys';


ALTER FUNCTION public.skeys(hstore) OWNER TO postgres;

--
-- TOC entry 726 (class 1255 OID 17211)
-- Dependencies: 6
-- Name: sort(integer[], text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[], text) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[], text) OWNER TO postgres;

--
-- TOC entry 727 (class 1255 OID 17212)
-- Dependencies: 6
-- Name: sort(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[]) OWNER TO postgres;

--
-- TOC entry 728 (class 1255 OID 17213)
-- Dependencies: 6
-- Name: sort_asc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_asc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_asc';


ALTER FUNCTION public.sort_asc(integer[]) OWNER TO postgres;

--
-- TOC entry 729 (class 1255 OID 17214)
-- Dependencies: 6
-- Name: sort_desc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_desc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_desc';


ALTER FUNCTION public.sort_desc(integer[]) OWNER TO postgres;

--
-- TOC entry 730 (class 1255 OID 17215)
-- Dependencies: 6
-- Name: soundex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION soundex(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'soundex';


ALTER FUNCTION public.soundex(text) OWNER TO postgres;

--
-- TOC entry 731 (class 1255 OID 17216)
-- Dependencies: 6
-- Name: ssl_client_cert_present(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_cert_present() RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_cert_present';


ALTER FUNCTION public.ssl_client_cert_present() OWNER TO postgres;

--
-- TOC entry 732 (class 1255 OID 17217)
-- Dependencies: 6
-- Name: ssl_client_dn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_dn() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_dn';


ALTER FUNCTION public.ssl_client_dn() OWNER TO postgres;

--
-- TOC entry 733 (class 1255 OID 17218)
-- Dependencies: 6
-- Name: ssl_client_dn_field(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_dn_field(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_dn_field';


ALTER FUNCTION public.ssl_client_dn_field(text) OWNER TO postgres;

--
-- TOC entry 734 (class 1255 OID 17219)
-- Dependencies: 6
-- Name: ssl_client_serial(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_serial() RETURNS numeric
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_serial';


ALTER FUNCTION public.ssl_client_serial() OWNER TO postgres;

--
-- TOC entry 735 (class 1255 OID 17220)
-- Dependencies: 6
-- Name: ssl_is_used(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_is_used() RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_is_used';


ALTER FUNCTION public.ssl_is_used() OWNER TO postgres;

--
-- TOC entry 736 (class 1255 OID 17221)
-- Dependencies: 6
-- Name: ssl_issuer_dn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_issuer_dn() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_issuer_dn';


ALTER FUNCTION public.ssl_issuer_dn() OWNER TO postgres;

--
-- TOC entry 737 (class 1255 OID 17222)
-- Dependencies: 6
-- Name: ssl_issuer_field(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_issuer_field(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_issuer_field';


ALTER FUNCTION public.ssl_issuer_field(text) OWNER TO postgres;

--
-- TOC entry 738 (class 1255 OID 17223)
-- Dependencies: 6
-- Name: subarray(integer[], integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer, integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer, integer) OWNER TO postgres;

--
-- TOC entry 739 (class 1255 OID 17224)
-- Dependencies: 6
-- Name: subarray(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer) OWNER TO postgres;

--
-- TOC entry 740 (class 1255 OID 17225)
-- Dependencies: 6 1130 1130
-- Name: subltree(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subltree(ltree, integer, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subltree';


ALTER FUNCTION public.subltree(ltree, integer, integer) OWNER TO postgres;

--
-- TOC entry 741 (class 1255 OID 17226)
-- Dependencies: 1130 1130 6
-- Name: subpath(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subpath(ltree, integer, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subpath';


ALTER FUNCTION public.subpath(ltree, integer, integer) OWNER TO postgres;

--
-- TOC entry 742 (class 1255 OID 17227)
-- Dependencies: 1130 6 1130
-- Name: subpath(ltree, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subpath(ltree, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subpath';


ALTER FUNCTION public.subpath(ltree, integer) OWNER TO postgres;

--
-- TOC entry 743 (class 1255 OID 17228)
-- Dependencies: 6 1102
-- Name: svals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION svals(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'svals';


ALTER FUNCTION public.svals(hstore) OWNER TO postgres;

--
-- TOC entry 744 (class 1255 OID 17229)
-- Dependencies: 1102 6
-- Name: tconvert(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tconvert(text, text) RETURNS hstore
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'tconvert';


ALTER FUNCTION public.tconvert(text, text) OWNER TO postgres;

--
-- TOC entry 745 (class 1255 OID 17230)
-- Dependencies: 1130 6
-- Name: text2ltree(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION text2ltree(text) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'text2ltree';


ALTER FUNCTION public.text2ltree(text) OWNER TO postgres;

--
-- TOC entry 746 (class 1255 OID 17231)
-- Dependencies: 6
-- Name: text_soundex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION text_soundex(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'soundex';


ALTER FUNCTION public.text_soundex(text) OWNER TO postgres;

--
-- TOC entry 747 (class 1255 OID 17232)
-- Dependencies: 6
-- Name: timetravel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION timetravel() RETURNS trigger
    LANGUAGE c
    AS '$libdir/timetravel', 'timetravel';


ALTER FUNCTION public.timetravel() OWNER TO postgres;

--
-- TOC entry 748 (class 1255 OID 17233)
-- Dependencies: 6
-- Name: uniq(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uniq(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'uniq';


ALTER FUNCTION public.uniq(integer[]) OWNER TO postgres;

--
-- TOC entry 749 (class 1255 OID 17234)
-- Dependencies: 1155 6 1072
-- Name: upc(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION upc(ean13) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'upc_cast_from_ean13';


ALTER FUNCTION public.upc(ean13) OWNER TO postgres;

--
-- TOC entry 750 (class 1255 OID 17235)
-- Dependencies: 6
-- Name: uuid_generate_v1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v1() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v1';


ALTER FUNCTION public.uuid_generate_v1() OWNER TO postgres;

--
-- TOC entry 751 (class 1255 OID 17236)
-- Dependencies: 6
-- Name: uuid_generate_v1mc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v1mc() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v1mc';


ALTER FUNCTION public.uuid_generate_v1mc() OWNER TO postgres;

--
-- TOC entry 752 (class 1255 OID 17237)
-- Dependencies: 6
-- Name: uuid_generate_v3(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v3(namespace uuid, name text) RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v3';


ALTER FUNCTION public.uuid_generate_v3(namespace uuid, name text) OWNER TO postgres;

--
-- TOC entry 753 (class 1255 OID 17238)
-- Dependencies: 6
-- Name: uuid_generate_v4(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v4() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v4';


ALTER FUNCTION public.uuid_generate_v4() OWNER TO postgres;

--
-- TOC entry 754 (class 1255 OID 17239)
-- Dependencies: 6
-- Name: uuid_generate_v5(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v5(namespace uuid, name text) RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v5';


ALTER FUNCTION public.uuid_generate_v5(namespace uuid, name text) OWNER TO postgres;

--
-- TOC entry 755 (class 1255 OID 17240)
-- Dependencies: 6
-- Name: uuid_nil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_nil() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_nil';


ALTER FUNCTION public.uuid_nil() OWNER TO postgres;

--
-- TOC entry 756 (class 1255 OID 17241)
-- Dependencies: 6
-- Name: uuid_ns_dns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_dns() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_dns';


ALTER FUNCTION public.uuid_ns_dns() OWNER TO postgres;

--
-- TOC entry 757 (class 1255 OID 17242)
-- Dependencies: 6
-- Name: uuid_ns_oid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_oid() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_oid';


ALTER FUNCTION public.uuid_ns_oid() OWNER TO postgres;

--
-- TOC entry 758 (class 1255 OID 17243)
-- Dependencies: 6
-- Name: uuid_ns_url(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_url() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_url';


ALTER FUNCTION public.uuid_ns_url() OWNER TO postgres;

--
-- TOC entry 759 (class 1255 OID 17244)
-- Dependencies: 6
-- Name: uuid_ns_x500(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_x500() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_x500';


ALTER FUNCTION public.uuid_ns_x500() OWNER TO postgres;

--
-- TOC entry 2790 (class 1259 OID 17245)
-- Dependencies: 2910 6
-- Name: verdad; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW verdad AS
    SELECT pregunta.id, count(*) AS "TRUE" FROM examen, pregunta, respuesta WHERE ((((respuesta.pregunta_id = pregunta.id) AND (respuesta.acertada = true)) AND (examen.id = respuesta.examen_id)) AND (respuesta.examen_id = 52)) GROUP BY pregunta.id ORDER BY pregunta.id;


ALTER TABLE public.verdad OWNER TO root;

--
-- TOC entry 760 (class 1255 OID 17249)
-- Dependencies: 1170 6 1229
-- Name: verdaderas(integer); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION verdaderas(integer) RETURNS SETOF verdad
    LANGUAGE plpgsql
    AS $_$
DECLARE
    r verdad%rowtype;
    exam integer;
BEGIN
exam = $1;
  FOR r IN SELECT pregunta.id, count(*) AS "TRUE"
    FROM examen, pregunta, respuesta
    WHERE respuesta.pregunta_id = pregunta.id AND respuesta.acertada = true AND examen.id = respuesta.examen_id AND respuesta.examen_id = exam
           GROUP BY pregunta.id
           ORDER BY pregunta.id
    LOOP
        
        RETURN NEXT r; 
    END LOOP;
    RETURN;
END
$_$;


ALTER FUNCTION public.verdaderas(integer) OWNER TO root;

--
-- TOC entry 761 (class 1255 OID 17250)
-- Dependencies: 6
-- Name: xml_encode_special_chars(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_encode_special_chars(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_encode_special_chars';


ALTER FUNCTION public.xml_encode_special_chars(text) OWNER TO postgres;

--
-- TOC entry 762 (class 1255 OID 17251)
-- Dependencies: 6
-- Name: xml_is_well_formed(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_is_well_formed(text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_is_well_formed';


ALTER FUNCTION public.xml_is_well_formed(text) OWNER TO postgres;

--
-- TOC entry 763 (class 1255 OID 17252)
-- Dependencies: 6
-- Name: xml_valid(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_valid(text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_is_well_formed';


ALTER FUNCTION public.xml_valid(text) OWNER TO postgres;

--
-- TOC entry 764 (class 1255 OID 17253)
-- Dependencies: 6
-- Name: xpath_bool(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_bool(text, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_bool';


ALTER FUNCTION public.xpath_bool(text, text) OWNER TO postgres;

--
-- TOC entry 765 (class 1255 OID 17254)
-- Dependencies: 6
-- Name: xpath_list(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_list(text, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_list';


ALTER FUNCTION public.xpath_list(text, text, text) OWNER TO postgres;

--
-- TOC entry 766 (class 1255 OID 17255)
-- Dependencies: 6
-- Name: xpath_list(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_list(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_list($1,$2,',')$_$;


ALTER FUNCTION public.xpath_list(text, text) OWNER TO postgres;

--
-- TOC entry 767 (class 1255 OID 17256)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_nodeset';


ALTER FUNCTION public.xpath_nodeset(text, text, text, text) OWNER TO postgres;

--
-- TOC entry 768 (class 1255 OID 17257)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'','')$_$;


ALTER FUNCTION public.xpath_nodeset(text, text) OWNER TO postgres;

--
-- TOC entry 769 (class 1255 OID 17258)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'',$3)$_$;


ALTER FUNCTION public.xpath_nodeset(text, text, text) OWNER TO postgres;

--
-- TOC entry 770 (class 1255 OID 17259)
-- Dependencies: 6
-- Name: xpath_number(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_number(text, text) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_number';


ALTER FUNCTION public.xpath_number(text, text) OWNER TO postgres;

--
-- TOC entry 771 (class 1255 OID 17260)
-- Dependencies: 6
-- Name: xpath_string(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_string(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_string';


ALTER FUNCTION public.xpath_string(text, text) OWNER TO postgres;

--
-- TOC entry 772 (class 1255 OID 17261)
-- Dependencies: 6
-- Name: xpath_table(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_table(text, text, text, text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/pgxml', 'xpath_table';


ALTER FUNCTION public.xpath_table(text, text, text, text, text) OWNER TO postgres;

--
-- TOC entry 773 (class 1255 OID 17262)
-- Dependencies: 6
-- Name: xslt_process(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xslt_process(text, text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgxml', 'xslt_process';


ALTER FUNCTION public.xslt_process(text, text, text) OWNER TO postgres;

--
-- TOC entry 774 (class 1255 OID 17263)
-- Dependencies: 6
-- Name: xslt_process(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xslt_process(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xslt_process';


ALTER FUNCTION public.xslt_process(text, text) OWNER TO postgres;

--
-- TOC entry 1934 (class 2617 OID 17264)
-- Dependencies: 416 6
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = icount,
    RIGHTARG = integer[]
);


ALTER OPERATOR public.# (NONE, integer[]) OWNER TO postgres;

--
-- TOC entry 1935 (class 2617 OID 17265)
-- Dependencies: 6 417
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = idx,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.# (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1936 (class 2617 OID 17266)
-- Dependencies: 724 6
-- Name: %; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR % (
    PROCEDURE = similarity_op,
    LEFTARG = text,
    RIGHTARG = text,
    COMMUTATOR = %,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.% (text, text) OWNER TO postgres;

--
-- TOC entry 1937 (class 2617 OID 17267)
-- Dependencies: 6 76
-- Name: &; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR & (
    PROCEDURE = _int_inter,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &
);


ALTER OPERATOR public.& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1938 (class 2617 OID 17268)
-- Dependencies: 6 1067 1067 173
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = cube_overlap,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (cube, cube) OWNER TO postgres;

--
-- TOC entry 1939 (class 2617 OID 17269)
-- Dependencies: 77 6
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = _int_overlap,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.&& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1940 (class 2617 OID 17270)
-- Dependencies: 1144 713 6 1144
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = seg_overlap,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (seg, seg) OWNER TO postgres;

--
-- TOC entry 1941 (class 2617 OID 17271)
-- Dependencies: 1144 1144 6 711
-- Name: &<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &< (
    PROCEDURE = seg_over_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (seg, seg) OWNER TO postgres;

--
-- TOC entry 1942 (class 2617 OID 17272)
-- Dependencies: 1144 712 6 1144
-- Name: &>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &> (
    PROCEDURE = seg_over_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (seg, seg) OWNER TO postgres;

--
-- TOC entry 1943 (class 2617 OID 17273)
-- Dependencies: 423 6
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.+ (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1944 (class 2617 OID 17274)
-- Dependencies: 422 6
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_array,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1945 (class 2617 OID 17275)
-- Dependencies: 421 6
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intarray_del_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.- (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1946 (class 2617 OID 17276)
-- Dependencies: 6 425
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intset_subtract,
    LEFTARG = integer[],
    RIGHTARG = integer[]
);


ALTER OPERATOR public.- (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1947 (class 2617 OID 17277)
-- Dependencies: 233 6 1102
-- Name: ->; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR -> (
    PROCEDURE = fetchval,
    LEFTARG = hstore,
    RIGHTARG = text
);


ALTER OPERATOR public.-> (hstore, text) OWNER TO postgres;

--
-- TOC entry 1948 (class 2617 OID 17280)
-- Dependencies: 1067 1067 6 171
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = cube_lt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (cube, cube) OWNER TO postgres;

--
-- TOC entry 1951 (class 2617 OID 17283)
-- Dependencies: 1072 555 1072 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1954 (class 2617 OID 17286)
-- Dependencies: 1111 556 1072 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1957 (class 2617 OID 17289)
-- Dependencies: 565 1111 6 1072
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1960 (class 2617 OID 17292)
-- Dependencies: 1117 557 6 1072
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1963 (class 2617 OID 17295)
-- Dependencies: 571 6 1117 1072
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1966 (class 2617 OID 17298)
-- Dependencies: 558 6 1072 1123
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1969 (class 2617 OID 17301)
-- Dependencies: 1072 577 6 1123
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1972 (class 2617 OID 17304)
-- Dependencies: 1072 6 1108 559
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1975 (class 2617 OID 17307)
-- Dependencies: 1072 568 1108 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1978 (class 2617 OID 17310)
-- Dependencies: 1072 6 1114 560
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1981 (class 2617 OID 17313)
-- Dependencies: 6 574 1072 1114
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1984 (class 2617 OID 17316)
-- Dependencies: 6 1072 1120 561
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1986 (class 2617 OID 17319)
-- Dependencies: 1120 580 1072 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1989 (class 2617 OID 17322)
-- Dependencies: 1155 562 6 1072
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, upc) OWNER TO postgres;

--
-- TOC entry 1992 (class 2617 OID 17325)
-- Dependencies: 6 582 1155 1072
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, ean13) OWNER TO postgres;

--
-- TOC entry 1996 (class 2617 OID 17328)
-- Dependencies: 1111 6 563 1111
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 1997 (class 2617 OID 17331)
-- Dependencies: 564 1108 1111 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2000 (class 2617 OID 17334)
-- Dependencies: 1108 6 567 1111
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2003 (class 2617 OID 17337)
-- Dependencies: 566 1108 1108 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2006 (class 2617 OID 17340)
-- Dependencies: 1117 6 1117 569
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2009 (class 2617 OID 17343)
-- Dependencies: 6 1117 1114 570
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2012 (class 2617 OID 17346)
-- Dependencies: 573 1117 1114 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2015 (class 2617 OID 17349)
-- Dependencies: 1114 572 1114 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2018 (class 2617 OID 17352)
-- Dependencies: 575 6 1123 1123
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2021 (class 2617 OID 17355)
-- Dependencies: 1123 6 576 1120
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2024 (class 2617 OID 17358)
-- Dependencies: 1120 6 1123 579
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2027 (class 2617 OID 17361)
-- Dependencies: 6 1120 1120 578
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn) OWNER TO postgres;

--
-- TOC entry 2030 (class 2617 OID 17364)
-- Dependencies: 1155 581 6 1155
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, upc) OWNER TO postgres;

--
-- TOC entry 2033 (class 2617 OID 17367)
-- Dependencies: 6 1130 1130 644
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = ltree_lt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2036 (class 2617 OID 17370)
-- Dependencies: 1144 6 710 1144
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = seg_lt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (seg, seg) OWNER TO postgres;

--
-- TOC entry 2039 (class 2617 OID 17372)
-- Dependencies: 1144 708 1144 6
-- Name: <<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR << (
    PROCEDURE = seg_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (seg, seg) OWNER TO postgres;

--
-- TOC entry 2040 (class 2617 OID 17373)
-- Dependencies: 6 169 1067 1067
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = cube_le,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (cube, cube) OWNER TO postgres;

--
-- TOC entry 2041 (class 2617 OID 17374)
-- Dependencies: 1072 527 1072 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2042 (class 2617 OID 17375)
-- Dependencies: 528 1111 1072 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2043 (class 2617 OID 17376)
-- Dependencies: 6 537 1072 1111
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2044 (class 2617 OID 17377)
-- Dependencies: 1117 529 1072 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2045 (class 2617 OID 17378)
-- Dependencies: 6 1117 1072 543
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2046 (class 2617 OID 17379)
-- Dependencies: 1123 530 6 1072
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2048 (class 2617 OID 17380)
-- Dependencies: 1072 549 1123 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2049 (class 2617 OID 17381)
-- Dependencies: 531 1108 1072 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2050 (class 2617 OID 17382)
-- Dependencies: 1108 540 6 1072
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2051 (class 2617 OID 17383)
-- Dependencies: 1114 6 1072 532
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2052 (class 2617 OID 17384)
-- Dependencies: 6 546 1072 1114
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2053 (class 2617 OID 17385)
-- Dependencies: 1120 533 6 1072
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2054 (class 2617 OID 17386)
-- Dependencies: 552 1072 6 1120
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2055 (class 2617 OID 17387)
-- Dependencies: 1072 534 6 1155
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2056 (class 2617 OID 17388)
-- Dependencies: 1072 554 6 1155
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2057 (class 2617 OID 17389)
-- Dependencies: 1111 535 6 1111
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2058 (class 2617 OID 17390)
-- Dependencies: 1108 536 6 1111
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2059 (class 2617 OID 17391)
-- Dependencies: 1111 539 6 1108
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2060 (class 2617 OID 17392)
-- Dependencies: 1108 538 6 1108
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2061 (class 2617 OID 17393)
-- Dependencies: 1117 6 541 1117
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2062 (class 2617 OID 17394)
-- Dependencies: 1117 542 6 1114
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2063 (class 2617 OID 17395)
-- Dependencies: 1117 6 1114 545
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2064 (class 2617 OID 17396)
-- Dependencies: 6 544 1114 1114
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2065 (class 2617 OID 17397)
-- Dependencies: 6 547 1123 1123
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2066 (class 2617 OID 17398)
-- Dependencies: 6 1123 548 1120
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2067 (class 2617 OID 17399)
-- Dependencies: 1120 551 6 1123
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2068 (class 2617 OID 17400)
-- Dependencies: 1120 6 550 1120
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn) OWNER TO postgres;

--
-- TOC entry 2069 (class 2617 OID 17401)
-- Dependencies: 1155 6 1155 553
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2070 (class 2617 OID 17402)
-- Dependencies: 1130 1130 643 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = ltree_le,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2071 (class 2617 OID 17403)
-- Dependencies: 1144 1144 6 707
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = seg_le,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2072 (class 2617 OID 17405)
-- Dependencies: 1064 6 665
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = ne,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = =
);


ALTER OPERATOR public.<> (chkpass, text) OWNER TO postgres;

--
-- TOC entry 2074 (class 2617 OID 17407)
-- Dependencies: 1067 172 6 1067
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = cube_ne,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (cube, cube) OWNER TO postgres;

--
-- TOC entry 2076 (class 2617 OID 17409)
-- Dependencies: 1072 583 6 1072
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2080 (class 2617 OID 17410)
-- Dependencies: 6 1111 584 1072
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2078 (class 2617 OID 17412)
-- Dependencies: 1072 6 593 1111
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2084 (class 2617 OID 17414)
-- Dependencies: 1072 585 1117 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2082 (class 2617 OID 17416)
-- Dependencies: 1117 6 1072 599
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2088 (class 2617 OID 17418)
-- Dependencies: 1123 586 6 1072
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2086 (class 2617 OID 17420)
-- Dependencies: 1072 605 6 1123
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2092 (class 2617 OID 17422)
-- Dependencies: 587 1072 6 1108
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2090 (class 2617 OID 17424)
-- Dependencies: 1108 596 6 1072
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2096 (class 2617 OID 17426)
-- Dependencies: 588 1072 6 1114
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2094 (class 2617 OID 17428)
-- Dependencies: 1072 602 6 1114
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2101 (class 2617 OID 17430)
-- Dependencies: 589 6 1072 1120
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2100 (class 2617 OID 17432)
-- Dependencies: 6 608 1072 1120
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2105 (class 2617 OID 17434)
-- Dependencies: 1155 6 1072 590
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2103 (class 2617 OID 17436)
-- Dependencies: 1072 610 1155 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2107 (class 2617 OID 17439)
-- Dependencies: 1111 6 1111 591
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2111 (class 2617 OID 17440)
-- Dependencies: 6 592 1108 1111
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2109 (class 2617 OID 17442)
-- Dependencies: 6 1108 1111 595
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2113 (class 2617 OID 17445)
-- Dependencies: 6 594 1108 1108
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2115 (class 2617 OID 17447)
-- Dependencies: 597 1117 1117 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2120 (class 2617 OID 17448)
-- Dependencies: 6 1114 1117 598
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2117 (class 2617 OID 17450)
-- Dependencies: 601 6 1114 1117
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2122 (class 2617 OID 17453)
-- Dependencies: 1114 6 1114 600
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2124 (class 2617 OID 17455)
-- Dependencies: 1123 6 603 1123
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2127 (class 2617 OID 17456)
-- Dependencies: 1123 1120 604 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2118 (class 2617 OID 17458)
-- Dependencies: 607 1120 1123 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2129 (class 2617 OID 17461)
-- Dependencies: 1120 1120 6 606
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn) OWNER TO postgres;

--
-- TOC entry 2131 (class 2617 OID 17463)
-- Dependencies: 6 1155 609 1155
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, upc) OWNER TO postgres;

--
-- TOC entry 2133 (class 2617 OID 17465)
-- Dependencies: 1130 1130 6 645
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = ltree_ne,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2135 (class 2617 OID 17467)
-- Dependencies: 1144 6 1144 703
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = seg_different,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2137 (class 2617 OID 17469)
-- Dependencies: 6 1067 1067 162
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2139 (class 2617 OID 17471)
-- Dependencies: 414 1102 6 1102
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2141 (class 2617 OID 17473)
-- Dependencies: 6 73
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2143 (class 2617 OID 17475)
-- Dependencies: 1130 1130 6 652 648
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2145 (class 2617 OID 17477)
-- Dependencies: 1132 92 6 1130
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2147 (class 2617 OID 17479)
-- Dependencies: 6 1130 94 1132
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2149 (class 2617 OID 17481)
-- Dependencies: 6 670 1144 1144
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2150 (class 2617 OID 17482)
-- Dependencies: 370 6
-- Name: <@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@> (
    PROCEDURE = geo_distance,
    LEFTARG = point,
    RIGHTARG = point,
    COMMUTATOR = <@>
);


ALTER OPERATOR public.<@> (point, point) OWNER TO postgres;

--
-- TOC entry 2098 (class 2617 OID 17404)
-- Dependencies: 6 230 1064
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = eq,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = <>
);


ALTER OPERATOR public.= (chkpass, text) OWNER TO postgres;

--
-- TOC entry 2073 (class 2617 OID 17406)
-- Dependencies: 165 6 1067 1067
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = cube_eq,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (cube, cube) OWNER TO postgres;

--
-- TOC entry 2075 (class 2617 OID 17408)
-- Dependencies: 1072 1072 443 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2079 (class 2617 OID 17411)
-- Dependencies: 1111 6 453 1072
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2077 (class 2617 OID 17413)
-- Dependencies: 1072 6 444 1111
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2083 (class 2617 OID 17415)
-- Dependencies: 1117 6 459 1072
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2081 (class 2617 OID 17417)
-- Dependencies: 6 1117 445 1072
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2087 (class 2617 OID 17419)
-- Dependencies: 6 465 1072 1123
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2085 (class 2617 OID 17421)
-- Dependencies: 1123 1072 6 446
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2091 (class 2617 OID 17423)
-- Dependencies: 1072 6 456 1108
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2089 (class 2617 OID 17425)
-- Dependencies: 1108 1072 6 447
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2095 (class 2617 OID 17427)
-- Dependencies: 1072 6 1114 462
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2093 (class 2617 OID 17429)
-- Dependencies: 1072 448 1114 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2152 (class 2617 OID 17431)
-- Dependencies: 468 1072 1120 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2151 (class 2617 OID 17433)
-- Dependencies: 449 6 1072 1120
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2104 (class 2617 OID 17435)
-- Dependencies: 470 1072 6 1155
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2102 (class 2617 OID 17437)
-- Dependencies: 450 6 1072 1155
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2106 (class 2617 OID 17438)
-- Dependencies: 6 451 1111 1111
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2110 (class 2617 OID 17441)
-- Dependencies: 455 6 1108 1111
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2108 (class 2617 OID 17443)
-- Dependencies: 1111 6 452 1108
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2112 (class 2617 OID 17444)
-- Dependencies: 6 1108 1108 454
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2114 (class 2617 OID 17446)
-- Dependencies: 6 457 1117 1117
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2119 (class 2617 OID 17449)
-- Dependencies: 461 6 1114 1117
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2116 (class 2617 OID 17451)
-- Dependencies: 458 6 1117 1114
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2121 (class 2617 OID 17452)
-- Dependencies: 6 460 1114 1114
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2123 (class 2617 OID 17454)
-- Dependencies: 463 6 1123 1123
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2126 (class 2617 OID 17457)
-- Dependencies: 1120 1123 467 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2125 (class 2617 OID 17459)
-- Dependencies: 1120 1123 6 464
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2128 (class 2617 OID 17460)
-- Dependencies: 1120 466 6 1120
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn) OWNER TO postgres;

--
-- TOC entry 2130 (class 2617 OID 17462)
-- Dependencies: 6 469 1155 1155
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2132 (class 2617 OID 17464)
-- Dependencies: 639 1130 1130 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = ltree_eq,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2134 (class 2617 OID 17466)
-- Dependencies: 1144 6 1144 715
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = seg_same,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2153 (class 2617 OID 17483)
-- Dependencies: 1102 744 6
-- Name: =>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR => (
    PROCEDURE = tconvert,
    LEFTARG = text,
    RIGHTARG = text
);


ALTER OPERATOR public.=> (text, text) OWNER TO postgres;

--
-- TOC entry 1990 (class 2617 OID 17278)
-- Dependencies: 6 1067 1067 167
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = cube_gt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (cube, cube) OWNER TO postgres;

--
-- TOC entry 1991 (class 2617 OID 17281)
-- Dependencies: 1072 6 1072 499
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1950 (class 2617 OID 17284)
-- Dependencies: 1111 6 509 1072
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1959 (class 2617 OID 17287)
-- Dependencies: 1072 6 1111 500
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1953 (class 2617 OID 17290)
-- Dependencies: 1117 515 1072 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1965 (class 2617 OID 17293)
-- Dependencies: 1072 501 1117 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1956 (class 2617 OID 17296)
-- Dependencies: 521 1072 1123 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1971 (class 2617 OID 17299)
-- Dependencies: 1123 6 502 1072
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1962 (class 2617 OID 17302)
-- Dependencies: 1072 1108 6 512
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1977 (class 2617 OID 17305)
-- Dependencies: 6 1072 1108 503
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1968 (class 2617 OID 17308)
-- Dependencies: 518 6 1114 1072
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1983 (class 2617 OID 17311)
-- Dependencies: 1114 1072 6 504
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1974 (class 2617 OID 17314)
-- Dependencies: 1072 1120 6 524
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1988 (class 2617 OID 17317)
-- Dependencies: 1120 6 1072 505
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1980 (class 2617 OID 17320)
-- Dependencies: 6 526 1072 1155
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, ean13) OWNER TO postgres;

--
-- TOC entry 1994 (class 2617 OID 17323)
-- Dependencies: 506 1155 1072 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2097 (class 2617 OID 17326)
-- Dependencies: 507 6 1111 1111
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2037 (class 2617 OID 17329)
-- Dependencies: 1108 511 6 1111
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2002 (class 2617 OID 17332)
-- Dependencies: 508 6 1111 1108
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2038 (class 2617 OID 17335)
-- Dependencies: 6 1108 1108 510
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 1999 (class 2617 OID 17338)
-- Dependencies: 513 1117 1117 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2005 (class 2617 OID 17341)
-- Dependencies: 1114 6 1117 517
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2014 (class 2617 OID 17344)
-- Dependencies: 514 6 1117 1114
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2008 (class 2617 OID 17347)
-- Dependencies: 1114 516 1114 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2011 (class 2617 OID 17350)
-- Dependencies: 519 6 1123 1123
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2017 (class 2617 OID 17353)
-- Dependencies: 523 1123 6 1120
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2026 (class 2617 OID 17356)
-- Dependencies: 520 1120 1123 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2020 (class 2617 OID 17359)
-- Dependencies: 522 6 1120 1120
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn) OWNER TO postgres;

--
-- TOC entry 2023 (class 2617 OID 17362)
-- Dependencies: 1155 525 1155 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, upc) OWNER TO postgres;

--
-- TOC entry 2029 (class 2617 OID 17365)
-- Dependencies: 641 1130 6 1130
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = ltree_gt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2032 (class 2617 OID 17368)
-- Dependencies: 1144 1144 705 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = seg_gt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (seg, seg) OWNER TO postgres;

--
-- TOC entry 1985 (class 2617 OID 17279)
-- Dependencies: 6 166 1067 1067
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = cube_ge,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (cube, cube) OWNER TO postgres;

--
-- TOC entry 1995 (class 2617 OID 17282)
-- Dependencies: 471 6 1072 1072
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1949 (class 2617 OID 17285)
-- Dependencies: 1072 6 472 1111
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1958 (class 2617 OID 17288)
-- Dependencies: 481 1072 1111 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1952 (class 2617 OID 17291)
-- Dependencies: 1072 6 473 1117
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1964 (class 2617 OID 17294)
-- Dependencies: 1117 487 6 1072
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1955 (class 2617 OID 17297)
-- Dependencies: 1123 474 6 1072
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1970 (class 2617 OID 17300)
-- Dependencies: 1123 6 1072 493
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1961 (class 2617 OID 17303)
-- Dependencies: 6 1108 1072 475
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1976 (class 2617 OID 17306)
-- Dependencies: 1072 6 1108 484
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1967 (class 2617 OID 17309)
-- Dependencies: 1072 6 1114 476
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1982 (class 2617 OID 17312)
-- Dependencies: 1114 490 1072 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1973 (class 2617 OID 17315)
-- Dependencies: 6 1072 1120 477
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1987 (class 2617 OID 17318)
-- Dependencies: 6 1120 1072 496
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1979 (class 2617 OID 17321)
-- Dependencies: 1072 6 478 1155
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 1993 (class 2617 OID 17324)
-- Dependencies: 6 1155 1072 498
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2099 (class 2617 OID 17327)
-- Dependencies: 1111 6 479 1111
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2035 (class 2617 OID 17330)
-- Dependencies: 1108 480 6 1111
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2001 (class 2617 OID 17333)
-- Dependencies: 1108 1111 483 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2047 (class 2617 OID 17336)
-- Dependencies: 1108 482 1108 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 1998 (class 2617 OID 17339)
-- Dependencies: 6 485 1117 1117
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2004 (class 2617 OID 17342)
-- Dependencies: 1117 1114 6 486
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2013 (class 2617 OID 17345)
-- Dependencies: 489 6 1114 1117
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2007 (class 2617 OID 17348)
-- Dependencies: 6 488 1114 1114
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2010 (class 2617 OID 17351)
-- Dependencies: 6 1123 1123 491
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2016 (class 2617 OID 17354)
-- Dependencies: 1123 6 492 1120
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2025 (class 2617 OID 17357)
-- Dependencies: 495 6 1120 1123
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2019 (class 2617 OID 17360)
-- Dependencies: 6 494 1120 1120
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn) OWNER TO postgres;

--
-- TOC entry 2022 (class 2617 OID 17363)
-- Dependencies: 1155 497 6 1155
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2028 (class 2617 OID 17366)
-- Dependencies: 640 1130 6 1130
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = ltree_ge,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2031 (class 2617 OID 17369)
-- Dependencies: 6 704 1144 1144
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = seg_ge,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2034 (class 2617 OID 17371)
-- Dependencies: 714 6 1144 1144
-- Name: >>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >> (
    PROCEDURE = seg_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2154 (class 2617 OID 17484)
-- Dependencies: 6 1102 232
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = exist,
    LEFTARG = hstore,
    RIGHTARG = text,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (hstore, text) OWNER TO postgres;

--
-- TOC entry 2156 (class 2617 OID 17485)
-- Dependencies: 6 1130 1129 629
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 2155 (class 2617 OID 17486)
-- Dependencies: 1130 6 1129 628
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 2159 (class 2617 OID 17487)
-- Dependencies: 1129 1132 81 6
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 2157 (class 2617 OID 17488)
-- Dependencies: 80 1129 1132 6
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 2160 (class 2617 OID 17489)
-- Dependencies: 1132 88 1130 1130 6
-- Name: ?<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?<@ (
    PROCEDURE = _ltree_extract_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2161 (class 2617 OID 17490)
-- Dependencies: 1132 1130 98 6 1136
-- Name: ?@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?@ (
    PROCEDURE = _ltxtq_extract_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery
);


ALTER OPERATOR public.?@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2162 (class 2617 OID 17491)
-- Dependencies: 1132 1130 1130 87 6
-- Name: ?@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?@> (
    PROCEDURE = _ltree_extract_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2163 (class 2617 OID 17492)
-- Dependencies: 6 1127 1130 82 1132
-- Name: ?~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?~ (
    PROCEDURE = _ltq_extract_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery
);


ALTER OPERATOR public.?~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2164 (class 2617 OID 17494)
-- Dependencies: 163 1067 6 1067
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2166 (class 2617 OID 17496)
-- Dependencies: 415 1102 1102 6
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2168 (class 2617 OID 17498)
-- Dependencies: 6 74
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2171 (class 2617 OID 17499)
-- Dependencies: 654 1136 6 1130
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 2170 (class 2617 OID 17500)
-- Dependencies: 6 653 1130 1136
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 2174 (class 2617 OID 17501)
-- Dependencies: 6 99 1136 1132
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2172 (class 2617 OID 17502)
-- Dependencies: 97 1132 1136 6
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2175 (class 2617 OID 17504)
-- Dependencies: 671 6 1144 1144
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2136 (class 2617 OID 17468)
-- Dependencies: 163 1067 1067 6
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (cube, cube) OWNER TO postgres;

--
-- TOC entry 2138 (class 2617 OID 17470)
-- Dependencies: 415 6 1102 1102
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2140 (class 2617 OID 17472)
-- Dependencies: 6 74
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2142 (class 2617 OID 17474)
-- Dependencies: 6 1130 652 642 1130
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2144 (class 2617 OID 17476)
-- Dependencies: 6 1132 89 1130
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2146 (class 2617 OID 17478)
-- Dependencies: 93 6 1130 1132
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2148 (class 2617 OID 17480)
-- Dependencies: 671 6 1144 1144
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2176 (class 2617 OID 17506)
-- Dependencies: 6 104 1141
-- Name: @@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @@ (
    PROCEDURE = boolop,
    LEFTARG = integer[],
    RIGHTARG = query_int,
    COMMUTATOR = ~~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (integer[], query_int) OWNER TO postgres;

--
-- TOC entry 2177 (class 2617 OID 17508)
-- Dependencies: 6 1130 1130 648
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2179 (class 2617 OID 17510)
-- Dependencies: 6 1130 1132 92
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2181 (class 2617 OID 17512)
-- Dependencies: 1132 6 1130 94
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2158 (class 2617 OID 17513)
-- Dependencies: 1130 6 1129 629
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 2183 (class 2617 OID 17514)
-- Dependencies: 628 1129 1130 6
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 2184 (class 2617 OID 17515)
-- Dependencies: 81 1132 6 1129
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 2173 (class 2617 OID 17516)
-- Dependencies: 6 1129 1132 80
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 2187 (class 2617 OID 17517)
-- Dependencies: 1130 6 654 1136
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 2185 (class 2617 OID 17518)
-- Dependencies: 6 653 1136 1130
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 2190 (class 2617 OID 17519)
-- Dependencies: 1136 6 1132 99
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2188 (class 2617 OID 17520)
-- Dependencies: 1132 97 1136 6
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2191 (class 2617 OID 17507)
-- Dependencies: 6 1130 1130 642
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2192 (class 2617 OID 17509)
-- Dependencies: 6 1132 89 1130
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2193 (class 2617 OID 17511)
-- Dependencies: 1132 6 1130 93
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2182 (class 2617 OID 17521)
-- Dependencies: 631 6 1127 1130
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree) OWNER TO postgres;

--
-- TOC entry 2178 (class 2617 OID 17522)
-- Dependencies: 1130 6 630 1127
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree, lquery) OWNER TO postgres;

--
-- TOC entry 2194 (class 2617 OID 17523)
-- Dependencies: 84 6 1127 1132
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2186 (class 2617 OID 17524)
-- Dependencies: 83 1132 1127 6
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2195 (class 2617 OID 17525)
-- Dependencies: 6 426
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = intset_union_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.| (integer[], integer) OWNER TO postgres;

--
-- TOC entry 2196 (class 2617 OID 17526)
-- Dependencies: 6 79
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = _int_union,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = |
);


ALTER OPERATOR public.| (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2180 (class 2617 OID 17527)
-- Dependencies: 1102 6 1102 1102 413
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = hs_concat,
    LEFTARG = hstore,
    RIGHTARG = hstore
);


ALTER OPERATOR public.|| (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2189 (class 2617 OID 17528)
-- Dependencies: 6 1130 1130 633 1130
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addltree,
    LEFTARG = ltree,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2197 (class 2617 OID 17529)
-- Dependencies: 634 6 1130 1130
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addtext,
    LEFTARG = ltree,
    RIGHTARG = text
);


ALTER OPERATOR public.|| (ltree, text) OWNER TO postgres;

--
-- TOC entry 2198 (class 2617 OID 17530)
-- Dependencies: 1130 6 650 1130
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_textadd,
    LEFTARG = text,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (text, ltree) OWNER TO postgres;

--
-- TOC entry 2199 (class 2617 OID 17493)
-- Dependencies: 1067 6 1067 162
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2165 (class 2617 OID 17495)
-- Dependencies: 6 1102 1102 414
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2167 (class 2617 OID 17497)
-- Dependencies: 6 73
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2169 (class 2617 OID 17503)
-- Dependencies: 1144 670 6 1144
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2201 (class 2617 OID 17531)
-- Dependencies: 6 631 1130 1127
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree) OWNER TO postgres;

--
-- TOC entry 2200 (class 2617 OID 17532)
-- Dependencies: 6 630 1127 1130
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree, lquery) OWNER TO postgres;

--
-- TOC entry 2204 (class 2617 OID 17533)
-- Dependencies: 1132 6 1127 84
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2202 (class 2617 OID 17534)
-- Dependencies: 6 83 1127 1132
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2203 (class 2617 OID 17505)
-- Dependencies: 6 1141 700
-- Name: ~~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~~ (
    PROCEDURE = rboolop,
    LEFTARG = query_int,
    RIGHTARG = integer[],
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~~ (query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 2474 (class 2753 OID 17535)
-- Dependencies: 6
-- Name: cube_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY cube_ops USING btree;


ALTER OPERATOR FAMILY public.cube_ops USING btree OWNER TO root;

--
-- TOC entry 2316 (class 2616 OID 17536)
-- Dependencies: 1067 6 2474
-- Name: cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS cube_ops
    DEFAULT FOR TYPE cube USING btree AS
    OPERATOR 1 <(cube,cube) ,
    OPERATOR 2 <=(cube,cube) ,
    OPERATOR 3 =(cube,cube) ,
    OPERATOR 4 >=(cube,cube) ,
    OPERATOR 5 >(cube,cube) ,
    FUNCTION 1 cube_cmp(cube,cube);


ALTER OPERATOR CLASS public.cube_ops USING btree OWNER TO postgres;

--
-- TOC entry 2475 (class 2753 OID 17543)
-- Dependencies: 6
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY isn_ops USING btree;
ALTER OPERATOR FAMILY isn_ops USING btree ADD
    OPERATOR 1 <(ismn,ean13) ,
    OPERATOR 1 <(ismn13,ismn) ,
    OPERATOR 1 <(ismn13,ean13) ,
    OPERATOR 1 <(isbn,isbn13) ,
    OPERATOR 1 <(isbn,ean13) ,
    OPERATOR 1 <(isbn13,isbn) ,
    OPERATOR 1 <(isbn13,ean13) ,
    OPERATOR 1 <(ean13,ismn13) ,
    OPERATOR 1 <(ean13,issn13) ,
    OPERATOR 1 <(ean13,isbn) ,
    OPERATOR 1 <(ean13,ismn) ,
    OPERATOR 1 <(ean13,issn) ,
    OPERATOR 1 <(ean13,isbn13) ,
    OPERATOR 1 <(ean13,upc) ,
    OPERATOR 1 <(upc,ean13) ,
    OPERATOR 1 <(issn,issn13) ,
    OPERATOR 1 <(issn,ean13) ,
    OPERATOR 1 <(issn13,issn) ,
    OPERATOR 1 <(issn13,ean13) ,
    OPERATOR 1 <(ismn,ismn13) ,
    OPERATOR 2 <=(ean13,issn) ,
    OPERATOR 2 <=(ean13,isbn13) ,
    OPERATOR 2 <=(ean13,ismn13) ,
    OPERATOR 2 <=(ean13,issn13) ,
    OPERATOR 2 <=(ean13,isbn) ,
    OPERATOR 2 <=(ean13,ismn) ,
    OPERATOR 2 <=(ean13,upc) ,
    OPERATOR 2 <=(isbn13,ean13) ,
    OPERATOR 2 <=(isbn13,isbn) ,
    OPERATOR 2 <=(isbn,ean13) ,
    OPERATOR 2 <=(isbn,isbn13) ,
    OPERATOR 2 <=(ismn13,ean13) ,
    OPERATOR 2 <=(ismn13,ismn) ,
    OPERATOR 2 <=(ismn,ean13) ,
    OPERATOR 2 <=(ismn,ismn13) ,
    OPERATOR 2 <=(issn13,ean13) ,
    OPERATOR 2 <=(issn13,issn) ,
    OPERATOR 2 <=(issn,ean13) ,
    OPERATOR 2 <=(issn,issn13) ,
    OPERATOR 2 <=(upc,ean13) ,
    OPERATOR 3 =(ean13,issn13) ,
    OPERATOR 3 =(issn,ean13) ,
    OPERATOR 3 =(issn,issn13) ,
    OPERATOR 3 =(isbn,ean13) ,
    OPERATOR 3 =(isbn,isbn13) ,
    OPERATOR 3 =(ismn13,ean13) ,
    OPERATOR 3 =(ismn13,ismn) ,
    OPERATOR 3 =(ean13,upc) ,
    OPERATOR 3 =(ean13,issn) ,
    OPERATOR 3 =(ismn,ean13) ,
    OPERATOR 3 =(ismn,ismn13) ,
    OPERATOR 3 =(ean13,ismn) ,
    OPERATOR 3 =(ean13,isbn) ,
    OPERATOR 3 =(ean13,isbn13) ,
    OPERATOR 3 =(issn13,ean13) ,
    OPERATOR 3 =(issn13,issn) ,
    OPERATOR 3 =(isbn13,isbn) ,
    OPERATOR 3 =(ean13,ismn13) ,
    OPERATOR 3 =(upc,ean13) ,
    OPERATOR 3 =(isbn13,ean13) ,
    OPERATOR 4 >=(ean13,ismn) ,
    OPERATOR 4 >=(ismn13,ean13) ,
    OPERATOR 4 >=(ismn13,ismn) ,
    OPERATOR 4 >=(ean13,upc) ,
    OPERATOR 4 >=(ismn,ean13) ,
    OPERATOR 4 >=(ismn,ismn13) ,
    OPERATOR 4 >=(ean13,issn) ,
    OPERATOR 4 >=(isbn13,ean13) ,
    OPERATOR 4 >=(isbn13,isbn) ,
    OPERATOR 4 >=(ean13,isbn) ,
    OPERATOR 4 >=(ean13,issn13) ,
    OPERATOR 4 >=(issn13,ean13) ,
    OPERATOR 4 >=(issn13,issn) ,
    OPERATOR 4 >=(isbn,ean13) ,
    OPERATOR 4 >=(isbn,isbn13) ,
    OPERATOR 4 >=(ean13,ismn13) ,
    OPERATOR 4 >=(ean13,isbn13) ,
    OPERATOR 4 >=(issn,ean13) ,
    OPERATOR 4 >=(issn,issn13) ,
    OPERATOR 4 >=(upc,ean13) ,
    OPERATOR 5 >(issn13,issn) ,
    OPERATOR 5 >(isbn,ean13) ,
    OPERATOR 5 >(isbn,isbn13) ,
    OPERATOR 5 >(ismn13,ean13) ,
    OPERATOR 5 >(ismn13,ismn) ,
    OPERATOR 5 >(isbn13,ean13) ,
    OPERATOR 5 >(ean13,isbn13) ,
    OPERATOR 5 >(issn,ean13) ,
    OPERATOR 5 >(issn,issn13) ,
    OPERATOR 5 >(ean13,ismn13) ,
    OPERATOR 5 >(ean13,issn13) ,
    OPERATOR 5 >(isbn13,isbn) ,
    OPERATOR 5 >(issn13,ean13) ,
    OPERATOR 5 >(ismn,ean13) ,
    OPERATOR 5 >(ismn,ismn13) ,
    OPERATOR 5 >(ean13,isbn) ,
    OPERATOR 5 >(ean13,ismn) ,
    OPERATOR 5 >(ean13,issn) ,
    OPERATOR 5 >(upc,ean13) ,
    OPERATOR 5 >(ean13,upc) ,
    FUNCTION 1 (ean13, isbn13) btean13cmp(ean13,isbn13) ,
    FUNCTION 1 (ean13, ismn13) btean13cmp(ean13,ismn13) ,
    FUNCTION 1 (ean13, issn13) btean13cmp(ean13,issn13) ,
    FUNCTION 1 (ean13, isbn) btean13cmp(ean13,isbn) ,
    FUNCTION 1 (ean13, ismn) btean13cmp(ean13,ismn) ,
    FUNCTION 1 (ean13, issn) btean13cmp(ean13,issn) ,
    FUNCTION 1 (ean13, upc) btean13cmp(ean13,upc) ,
    FUNCTION 1 (isbn13, ean13) btisbn13cmp(isbn13,ean13) ,
    FUNCTION 1 (isbn13, isbn) btisbn13cmp(isbn13,isbn) ,
    FUNCTION 1 (isbn, ean13) btisbncmp(isbn,ean13) ,
    FUNCTION 1 (isbn, isbn13) btisbncmp(isbn,isbn13) ,
    FUNCTION 1 (ismn13, ean13) btismn13cmp(ismn13,ean13) ,
    FUNCTION 1 (ismn13, ismn) btismn13cmp(ismn13,ismn) ,
    FUNCTION 1 (ismn, ean13) btismncmp(ismn,ean13) ,
    FUNCTION 1 (ismn, ismn13) btismncmp(ismn,ismn13) ,
    FUNCTION 1 (issn13, ean13) btissn13cmp(issn13,ean13) ,
    FUNCTION 1 (issn13, issn) btissn13cmp(issn13,issn) ,
    FUNCTION 1 (issn, ean13) btissncmp(issn,ean13) ,
    FUNCTION 1 (issn, issn13) btissncmp(issn,issn13) ,
    FUNCTION 1 (upc, ean13) btupccmp(upc,ean13);


ALTER OPERATOR FAMILY public.isn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2317 (class 2616 OID 17664)
-- Dependencies: 2475 6 1072
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ean13,ean13) ,
    OPERATOR 2 <=(ean13,ean13) ,
    OPERATOR 3 =(ean13,ean13) ,
    OPERATOR 4 >=(ean13,ean13) ,
    OPERATOR 5 >(ean13,ean13) ,
    FUNCTION 1 btean13cmp(ean13,ean13);


ALTER OPERATOR CLASS public.ean13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2476 (class 2753 OID 17671)
-- Dependencies: 6
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY isn_ops USING hash;
ALTER OPERATOR FAMILY isn_ops USING hash ADD
    OPERATOR 1 =(upc,ean13) ,
    OPERATOR 1 =(issn,issn13) ,
    OPERATOR 1 =(issn,ean13) ,
    OPERATOR 1 =(issn13,issn) ,
    OPERATOR 1 =(issn13,ean13) ,
    OPERATOR 1 =(ismn,ismn13) ,
    OPERATOR 1 =(ismn,ean13) ,
    OPERATOR 1 =(ismn13,ismn) ,
    OPERATOR 1 =(ismn13,ean13) ,
    OPERATOR 1 =(isbn,isbn13) ,
    OPERATOR 1 =(isbn,ean13) ,
    OPERATOR 1 =(isbn13,isbn) ,
    OPERATOR 1 =(isbn13,ean13) ,
    OPERATOR 1 =(ean13,upc) ,
    OPERATOR 1 =(ean13,issn) ,
    OPERATOR 1 =(ean13,ismn) ,
    OPERATOR 1 =(ean13,isbn) ,
    OPERATOR 1 =(ean13,issn13) ,
    OPERATOR 1 =(ean13,ismn13) ,
    OPERATOR 1 =(ean13,isbn13);


ALTER OPERATOR FAMILY public.isn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2318 (class 2616 OID 17692)
-- Dependencies: 6 1072 2476
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ean13,ean13) ,
    FUNCTION 1 hashean13(ean13);


ALTER OPERATOR CLASS public.ean13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2477 (class 2753 OID 17695)
-- Dependencies: 6
-- Name: gin__int_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gin__int_ops USING gin;


ALTER OPERATOR FAMILY public.gin__int_ops USING gin OWNER TO root;

--
-- TOC entry 2319 (class 2616 OID 17696)
-- Dependencies: 6 2477
-- Name: gin__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin__int_ops
    FOR TYPE integer[] USING gin AS
    STORAGE integer ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 ginarrayextract(anyarray,internal) ,
    FUNCTION 3 ginint4_queryextract(internal,internal,smallint) ,
    FUNCTION 4 ginint4_consistent(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin__int_ops USING gin OWNER TO postgres;

--
-- TOC entry 2478 (class 2753 OID 17708)
-- Dependencies: 6
-- Name: gin_hstore_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gin_hstore_ops USING gin;


ALTER OPERATOR FAMILY public.gin_hstore_ops USING gin OWNER TO root;

--
-- TOC entry 2320 (class 2616 OID 17709)
-- Dependencies: 6 1102 2478
-- Name: gin_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_hstore_ops
    DEFAULT FOR TYPE hstore USING gin AS
    STORAGE text ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_hstore(internal,internal) ,
    FUNCTION 3 gin_extract_hstore_query(internal,internal,smallint) ,
    FUNCTION 4 gin_consistent_hstore(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin_hstore_ops USING gin OWNER TO postgres;

--
-- TOC entry 2479 (class 2753 OID 17716)
-- Dependencies: 6
-- Name: gin_trgm_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gin_trgm_ops USING gin;


ALTER OPERATOR FAMILY public.gin_trgm_ops USING gin OWNER TO root;

--
-- TOC entry 2321 (class 2616 OID 17717)
-- Dependencies: 2479 6
-- Name: gin_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_trgm_ops
    FOR TYPE text USING gin AS
    STORAGE integer ,
    OPERATOR 1 %(text,text) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 gin_extract_trgm(text,internal) ,
    FUNCTION 3 gin_extract_trgm(text,internal,internal) ,
    FUNCTION 4 gin_trgm_consistent(internal,internal,text);


ALTER OPERATOR CLASS public.gin_trgm_ops USING gin OWNER TO postgres;

--
-- TOC entry 2480 (class 2753 OID 17723)
-- Dependencies: 6
-- Name: gist__int_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist__int_ops USING gist;


ALTER OPERATOR FAMILY public.gist__int_ops USING gist OWNER TO root;

--
-- TOC entry 2322 (class 2616 OID 17724)
-- Dependencies: 2480 6
-- Name: gist__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__int_ops
    DEFAULT FOR TYPE integer[] USING gist AS
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_int_consistent(internal,integer[],integer) ,
    FUNCTION 2 g_int_union(internal,internal) ,
    FUNCTION 3 g_int_compress(internal) ,
    FUNCTION 4 g_int_decompress(internal) ,
    FUNCTION 5 g_int_penalty(internal,internal,internal) ,
    FUNCTION 6 g_int_picksplit(internal,internal) ,
    FUNCTION 7 g_int_same(integer[],integer[],internal);


ALTER OPERATOR CLASS public.gist__int_ops USING gist OWNER TO postgres;

--
-- TOC entry 2481 (class 2753 OID 17739)
-- Dependencies: 6
-- Name: gist__intbig_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist__intbig_ops USING gist;


ALTER OPERATOR FAMILY public.gist__intbig_ops USING gist OWNER TO root;

--
-- TOC entry 2323 (class 2616 OID 17740)
-- Dependencies: 6 2481 1105
-- Name: gist__intbig_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__intbig_ops
    FOR TYPE integer[] USING gist AS
    STORAGE intbig_gkey ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_intbig_consistent(internal,internal,integer) ,
    FUNCTION 2 g_intbig_union(internal,internal) ,
    FUNCTION 3 g_intbig_compress(internal) ,
    FUNCTION 4 g_intbig_decompress(internal) ,
    FUNCTION 5 g_intbig_penalty(internal,internal,internal) ,
    FUNCTION 6 g_intbig_picksplit(internal,internal) ,
    FUNCTION 7 g_intbig_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__intbig_ops USING gist OWNER TO postgres;

--
-- TOC entry 2482 (class 2753 OID 17755)
-- Dependencies: 6
-- Name: gist__ltree_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist__ltree_ops USING gist;


ALTER OPERATOR FAMILY public.gist__ltree_ops USING gist OWNER TO root;

--
-- TOC entry 2324 (class 2616 OID 17756)
-- Dependencies: 1133 1132 2482 6
-- Name: gist__ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__ltree_ops
    DEFAULT FOR TYPE ltree[] USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 10 <@(ltree[],ltree) ,
    OPERATOR 11 @>(ltree,ltree[]) ,
    OPERATOR 12 ~(ltree[],lquery) ,
    OPERATOR 13 ~(lquery,ltree[]) ,
    OPERATOR 14 @(ltree[],ltxtquery) ,
    OPERATOR 15 @(ltxtquery,ltree[]) ,
    OPERATOR 16 ?(ltree[],lquery[]) ,
    OPERATOR 17 ?(lquery[],ltree[]) ,
    FUNCTION 1 _ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 _ltree_union(internal,internal) ,
    FUNCTION 3 _ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 _ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 _ltree_picksplit(internal,internal) ,
    FUNCTION 7 _ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__ltree_ops USING gist OWNER TO postgres;

--
-- TOC entry 2483 (class 2753 OID 17772)
-- Dependencies: 6
-- Name: gist_bit_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_bit_ops USING gist;


ALTER OPERATOR FAMILY public.gist_bit_ops USING gist OWNER TO root;

--
-- TOC entry 2325 (class 2616 OID 17773)
-- Dependencies: 2483 6 1093
-- Name: gist_bit_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bit_ops
    DEFAULT FOR TYPE bit USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit,bit) ,
    OPERATOR 2 <=(bit,bit) ,
    OPERATOR 3 =(bit,bit) ,
    OPERATOR 4 >=(bit,bit) ,
    OPERATOR 5 >(bit,bit) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bit_ops USING gist OWNER TO postgres;

--
-- TOC entry 2484 (class 2753 OID 17786)
-- Dependencies: 6
-- Name: gist_bpchar_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_bpchar_ops USING gist;


ALTER OPERATOR FAMILY public.gist_bpchar_ops USING gist OWNER TO root;

--
-- TOC entry 2326 (class 2616 OID 17787)
-- Dependencies: 1093 6 2484
-- Name: gist_bpchar_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bpchar_ops
    DEFAULT FOR TYPE character USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(character,character) ,
    OPERATOR 2 <=(character,character) ,
    OPERATOR 3 =(character,character) ,
    OPERATOR 4 >=(character,character) ,
    OPERATOR 5 >(character,character) ,
    FUNCTION 1 gbt_bpchar_consistent(internal,character,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_bpchar_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bpchar_ops USING gist OWNER TO postgres;

--
-- TOC entry 2485 (class 2753 OID 17800)
-- Dependencies: 6
-- Name: gist_bytea_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_bytea_ops USING gist;


ALTER OPERATOR FAMILY public.gist_bytea_ops USING gist OWNER TO root;

--
-- TOC entry 2327 (class 2616 OID 17801)
-- Dependencies: 1093 2485 6
-- Name: gist_bytea_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bytea_ops
    DEFAULT FOR TYPE bytea USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bytea,bytea) ,
    OPERATOR 2 <=(bytea,bytea) ,
    OPERATOR 3 =(bytea,bytea) ,
    OPERATOR 4 >=(bytea,bytea) ,
    OPERATOR 5 >(bytea,bytea) ,
    FUNCTION 1 gbt_bytea_consistent(internal,bytea,smallint) ,
    FUNCTION 2 gbt_bytea_union(bytea,internal) ,
    FUNCTION 3 gbt_bytea_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bytea_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bytea_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bytea_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bytea_ops USING gist OWNER TO postgres;

--
-- TOC entry 2486 (class 2753 OID 17814)
-- Dependencies: 6
-- Name: gist_cash_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_cash_ops USING gist;


ALTER OPERATOR FAMILY public.gist_cash_ops USING gist OWNER TO root;

--
-- TOC entry 2328 (class 2616 OID 17815)
-- Dependencies: 6 2486 1081
-- Name: gist_cash_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cash_ops
    DEFAULT FOR TYPE money USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(money,money) ,
    OPERATOR 2 <=(money,money) ,
    OPERATOR 3 =(money,money) ,
    OPERATOR 4 >=(money,money) ,
    OPERATOR 5 >(money,money) ,
    FUNCTION 1 gbt_cash_consistent(internal,money,smallint) ,
    FUNCTION 2 gbt_cash_union(bytea,internal) ,
    FUNCTION 3 gbt_cash_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_cash_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_cash_picksplit(internal,internal) ,
    FUNCTION 7 gbt_cash_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cash_ops USING gist OWNER TO postgres;

--
-- TOC entry 2487 (class 2753 OID 17828)
-- Dependencies: 6
-- Name: gist_cidr_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_cidr_ops USING gist;


ALTER OPERATOR FAMILY public.gist_cidr_ops USING gist OWNER TO root;

--
-- TOC entry 2329 (class 2616 OID 17829)
-- Dependencies: 6 2487 1081
-- Name: gist_cidr_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cidr_ops
    DEFAULT FOR TYPE cidr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) ,
    OPERATOR 2 <=(inet,inet) ,
    OPERATOR 3 =(inet,inet) ,
    OPERATOR 4 >=(inet,inet) ,
    OPERATOR 5 >(inet,inet) ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cidr_ops USING gist OWNER TO postgres;

--
-- TOC entry 2488 (class 2753 OID 17842)
-- Dependencies: 6
-- Name: gist_cube_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_cube_ops USING gist;


ALTER OPERATOR FAMILY public.gist_cube_ops USING gist OWNER TO root;

--
-- TOC entry 2330 (class 2616 OID 17843)
-- Dependencies: 6 2488 1067
-- Name: gist_cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cube_ops
    DEFAULT FOR TYPE cube USING gist AS
    OPERATOR 3 &&(cube,cube) ,
    OPERATOR 6 =(cube,cube) ,
    OPERATOR 7 @>(cube,cube) ,
    OPERATOR 8 <@(cube,cube) ,
    OPERATOR 13 @(cube,cube) ,
    OPERATOR 14 ~(cube,cube) ,
    FUNCTION 1 g_cube_consistent(internal,cube,integer) ,
    FUNCTION 2 g_cube_union(internal,internal) ,
    FUNCTION 3 g_cube_compress(internal) ,
    FUNCTION 4 g_cube_decompress(internal) ,
    FUNCTION 5 g_cube_penalty(internal,internal,internal) ,
    FUNCTION 6 g_cube_picksplit(internal,internal) ,
    FUNCTION 7 g_cube_same(cube,cube,internal);


ALTER OPERATOR CLASS public.gist_cube_ops USING gist OWNER TO postgres;

--
-- TOC entry 2489 (class 2753 OID 17857)
-- Dependencies: 6
-- Name: gist_date_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_date_ops USING gist;


ALTER OPERATOR FAMILY public.gist_date_ops USING gist OWNER TO root;

--
-- TOC entry 2331 (class 2616 OID 17858)
-- Dependencies: 6 1090 2489
-- Name: gist_date_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_date_ops
    DEFAULT FOR TYPE date USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(date,date) ,
    OPERATOR 2 <=(date,date) ,
    OPERATOR 3 =(date,date) ,
    OPERATOR 4 >=(date,date) ,
    OPERATOR 5 >(date,date) ,
    FUNCTION 1 gbt_date_consistent(internal,date,smallint) ,
    FUNCTION 2 gbt_date_union(bytea,internal) ,
    FUNCTION 3 gbt_date_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_date_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_date_picksplit(internal,internal) ,
    FUNCTION 7 gbt_date_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_date_ops USING gist OWNER TO postgres;

--
-- TOC entry 2490 (class 2753 OID 17871)
-- Dependencies: 6
-- Name: gist_float4_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_float4_ops USING gist;


ALTER OPERATOR FAMILY public.gist_float4_ops USING gist OWNER TO root;

--
-- TOC entry 2332 (class 2616 OID 17872)
-- Dependencies: 1090 2490 6
-- Name: gist_float4_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_float4_ops
    DEFAULT FOR TYPE real USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(real,real) ,
    OPERATOR 2 <=(real,real) ,
    OPERATOR 3 =(real,real) ,
    OPERATOR 4 >=(real,real) ,
    OPERATOR 5 >(real,real) ,
    FUNCTION 1 gbt_float4_consistent(internal,real,smallint) ,
    FUNCTION 2 gbt_float4_union(bytea,internal) ,
    FUNCTION 3 gbt_float4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float4_ops USING gist OWNER TO postgres;

--
-- TOC entry 2491 (class 2753 OID 17885)
-- Dependencies: 6
-- Name: gist_float8_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_float8_ops USING gist;


ALTER OPERATOR FAMILY public.gist_float8_ops USING gist OWNER TO root;

--
-- TOC entry 2333 (class 2616 OID 17886)
-- Dependencies: 2491 6 1081
-- Name: gist_float8_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_float8_ops
    DEFAULT FOR TYPE double precision USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(double precision,double precision) ,
    OPERATOR 2 <=(double precision,double precision) ,
    OPERATOR 3 =(double precision,double precision) ,
    OPERATOR 4 >=(double precision,double precision) ,
    OPERATOR 5 >(double precision,double precision) ,
    FUNCTION 1 gbt_float8_consistent(internal,double precision,smallint) ,
    FUNCTION 2 gbt_float8_union(bytea,internal) ,
    FUNCTION 3 gbt_float8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float8_ops USING gist OWNER TO postgres;

--
-- TOC entry 2492 (class 2753 OID 17899)
-- Dependencies: 6
-- Name: gist_hstore_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_hstore_ops USING gist;


ALTER OPERATOR FAMILY public.gist_hstore_ops USING gist OWNER TO root;

--
-- TOC entry 2334 (class 2616 OID 17900)
-- Dependencies: 1102 2492 6 1096
-- Name: gist_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_hstore_ops
    DEFAULT FOR TYPE hstore USING gist AS
    STORAGE ghstore ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    OPERATOR 13 @(hstore,hstore) ,
    FUNCTION 1 ghstore_consistent(internal,internal,integer) ,
    FUNCTION 2 ghstore_union(internal,internal) ,
    FUNCTION 3 ghstore_compress(internal) ,
    FUNCTION 4 ghstore_decompress(internal) ,
    FUNCTION 5 ghstore_penalty(internal,internal,internal) ,
    FUNCTION 6 ghstore_picksplit(internal,internal) ,
    FUNCTION 7 ghstore_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_hstore_ops USING gist OWNER TO postgres;

--
-- TOC entry 2493 (class 2753 OID 17911)
-- Dependencies: 6
-- Name: gist_inet_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_inet_ops USING gist;


ALTER OPERATOR FAMILY public.gist_inet_ops USING gist OWNER TO root;

--
-- TOC entry 2335 (class 2616 OID 17912)
-- Dependencies: 2493 6 1081
-- Name: gist_inet_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_inet_ops
    DEFAULT FOR TYPE inet USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) ,
    OPERATOR 2 <=(inet,inet) ,
    OPERATOR 3 =(inet,inet) ,
    OPERATOR 4 >=(inet,inet) ,
    OPERATOR 5 >(inet,inet) ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_inet_ops USING gist OWNER TO postgres;

--
-- TOC entry 2494 (class 2753 OID 17925)
-- Dependencies: 6
-- Name: gist_int2_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_int2_ops USING gist;


ALTER OPERATOR FAMILY public.gist_int2_ops USING gist OWNER TO root;

--
-- TOC entry 2336 (class 2616 OID 17926)
-- Dependencies: 1087 6 2494
-- Name: gist_int2_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int2_ops
    DEFAULT FOR TYPE smallint USING gist AS
    STORAGE gbtreekey4 ,
    OPERATOR 1 <(smallint,smallint) ,
    OPERATOR 2 <=(smallint,smallint) ,
    OPERATOR 3 =(smallint,smallint) ,
    OPERATOR 4 >=(smallint,smallint) ,
    OPERATOR 5 >(smallint,smallint) ,
    FUNCTION 1 gbt_int2_consistent(internal,smallint,smallint) ,
    FUNCTION 2 gbt_int2_union(bytea,internal) ,
    FUNCTION 3 gbt_int2_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int2_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int2_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int2_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int2_ops USING gist OWNER TO postgres;

--
-- TOC entry 2495 (class 2753 OID 17939)
-- Dependencies: 6
-- Name: gist_int4_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_int4_ops USING gist;


ALTER OPERATOR FAMILY public.gist_int4_ops USING gist OWNER TO root;

--
-- TOC entry 2337 (class 2616 OID 17940)
-- Dependencies: 6 1090 2495
-- Name: gist_int4_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int4_ops
    DEFAULT FOR TYPE integer USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(integer,integer) ,
    OPERATOR 2 <=(integer,integer) ,
    OPERATOR 3 =(integer,integer) ,
    OPERATOR 4 >=(integer,integer) ,
    OPERATOR 5 >(integer,integer) ,
    FUNCTION 1 gbt_int4_consistent(internal,integer,smallint) ,
    FUNCTION 2 gbt_int4_union(bytea,internal) ,
    FUNCTION 3 gbt_int4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int4_ops USING gist OWNER TO postgres;

--
-- TOC entry 2496 (class 2753 OID 17953)
-- Dependencies: 6
-- Name: gist_int8_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_int8_ops USING gist;


ALTER OPERATOR FAMILY public.gist_int8_ops USING gist OWNER TO root;

--
-- TOC entry 2338 (class 2616 OID 17954)
-- Dependencies: 2496 1081 6
-- Name: gist_int8_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int8_ops
    DEFAULT FOR TYPE bigint USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(bigint,bigint) ,
    OPERATOR 2 <=(bigint,bigint) ,
    OPERATOR 3 =(bigint,bigint) ,
    OPERATOR 4 >=(bigint,bigint) ,
    OPERATOR 5 >(bigint,bigint) ,
    FUNCTION 1 gbt_int8_consistent(internal,bigint,smallint) ,
    FUNCTION 2 gbt_int8_union(bytea,internal) ,
    FUNCTION 3 gbt_int8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int8_ops USING gist OWNER TO postgres;

--
-- TOC entry 2497 (class 2753 OID 17967)
-- Dependencies: 6
-- Name: gist_interval_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_interval_ops USING gist;


ALTER OPERATOR FAMILY public.gist_interval_ops USING gist OWNER TO root;

--
-- TOC entry 2339 (class 2616 OID 17968)
-- Dependencies: 1084 6 2497
-- Name: gist_interval_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_interval_ops
    DEFAULT FOR TYPE interval USING gist AS
    STORAGE gbtreekey32 ,
    OPERATOR 1 <(interval,interval) ,
    OPERATOR 2 <=(interval,interval) ,
    OPERATOR 3 =(interval,interval) ,
    OPERATOR 4 >=(interval,interval) ,
    OPERATOR 5 >(interval,interval) ,
    FUNCTION 1 gbt_intv_consistent(internal,interval,smallint) ,
    FUNCTION 2 gbt_intv_union(bytea,internal) ,
    FUNCTION 3 gbt_intv_compress(internal) ,
    FUNCTION 4 gbt_intv_decompress(internal) ,
    FUNCTION 5 gbt_intv_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_intv_picksplit(internal,internal) ,
    FUNCTION 7 gbt_intv_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_interval_ops USING gist OWNER TO postgres;

--
-- TOC entry 2498 (class 2753 OID 17981)
-- Dependencies: 6
-- Name: gist_ltree_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_ltree_ops USING gist;


ALTER OPERATOR FAMILY public.gist_ltree_ops USING gist OWNER TO root;

--
-- TOC entry 2340 (class 2616 OID 17982)
-- Dependencies: 2498 1133 1130 6
-- Name: gist_ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_ltree_ops
    DEFAULT FOR TYPE ltree USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    OPERATOR 10 @>(ltree,ltree) ,
    OPERATOR 11 <@(ltree,ltree) ,
    OPERATOR 12 ~(ltree,lquery) ,
    OPERATOR 13 ~(lquery,ltree) ,
    OPERATOR 14 @(ltree,ltxtquery) ,
    OPERATOR 15 @(ltxtquery,ltree) ,
    OPERATOR 16 ?(ltree,lquery[]) ,
    OPERATOR 17 ?(lquery[],ltree) ,
    FUNCTION 1 ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 ltree_union(internal,internal) ,
    FUNCTION 3 ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 ltree_picksplit(internal,internal) ,
    FUNCTION 7 ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_ltree_ops USING gist OWNER TO postgres;

--
-- TOC entry 2499 (class 2753 OID 18003)
-- Dependencies: 6
-- Name: gist_macaddr_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_macaddr_ops USING gist;


ALTER OPERATOR FAMILY public.gist_macaddr_ops USING gist OWNER TO root;

--
-- TOC entry 2341 (class 2616 OID 18004)
-- Dependencies: 2499 1081 6
-- Name: gist_macaddr_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_macaddr_ops
    DEFAULT FOR TYPE macaddr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(macaddr,macaddr) ,
    OPERATOR 2 <=(macaddr,macaddr) ,
    OPERATOR 3 =(macaddr,macaddr) ,
    OPERATOR 4 >=(macaddr,macaddr) ,
    OPERATOR 5 >(macaddr,macaddr) ,
    FUNCTION 1 gbt_macad_consistent(internal,macaddr,smallint) ,
    FUNCTION 2 gbt_macad_union(bytea,internal) ,
    FUNCTION 3 gbt_macad_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_macad_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_macad_picksplit(internal,internal) ,
    FUNCTION 7 gbt_macad_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_macaddr_ops USING gist OWNER TO postgres;

--
-- TOC entry 2500 (class 2753 OID 18017)
-- Dependencies: 6
-- Name: gist_numeric_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_numeric_ops USING gist;


ALTER OPERATOR FAMILY public.gist_numeric_ops USING gist OWNER TO root;

--
-- TOC entry 2342 (class 2616 OID 18018)
-- Dependencies: 2500 1093 6
-- Name: gist_numeric_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_numeric_ops
    DEFAULT FOR TYPE numeric USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(numeric,numeric) ,
    OPERATOR 2 <=(numeric,numeric) ,
    OPERATOR 3 =(numeric,numeric) ,
    OPERATOR 4 >=(numeric,numeric) ,
    OPERATOR 5 >(numeric,numeric) ,
    FUNCTION 1 gbt_numeric_consistent(internal,numeric,smallint) ,
    FUNCTION 2 gbt_numeric_union(bytea,internal) ,
    FUNCTION 3 gbt_numeric_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_numeric_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_numeric_picksplit(internal,internal) ,
    FUNCTION 7 gbt_numeric_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_numeric_ops USING gist OWNER TO postgres;

--
-- TOC entry 2501 (class 2753 OID 18031)
-- Dependencies: 6
-- Name: gist_oid_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_oid_ops USING gist;


ALTER OPERATOR FAMILY public.gist_oid_ops USING gist OWNER TO root;

--
-- TOC entry 2343 (class 2616 OID 18032)
-- Dependencies: 1090 6 2501
-- Name: gist_oid_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_oid_ops
    DEFAULT FOR TYPE oid USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(oid,oid) ,
    OPERATOR 2 <=(oid,oid) ,
    OPERATOR 3 =(oid,oid) ,
    OPERATOR 4 >=(oid,oid) ,
    OPERATOR 5 >(oid,oid) ,
    FUNCTION 1 gbt_oid_consistent(internal,oid,smallint) ,
    FUNCTION 2 gbt_oid_union(bytea,internal) ,
    FUNCTION 3 gbt_oid_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_oid_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_oid_picksplit(internal,internal) ,
    FUNCTION 7 gbt_oid_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_oid_ops USING gist OWNER TO postgres;

--
-- TOC entry 2502 (class 2753 OID 18045)
-- Dependencies: 6
-- Name: gist_seg_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_seg_ops USING gist;


ALTER OPERATOR FAMILY public.gist_seg_ops USING gist OWNER TO root;

--
-- TOC entry 2344 (class 2616 OID 18046)
-- Dependencies: 6 2502 1144
-- Name: gist_seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_seg_ops
    DEFAULT FOR TYPE seg USING gist AS
    OPERATOR 1 <<(seg,seg) ,
    OPERATOR 2 &<(seg,seg) ,
    OPERATOR 3 &&(seg,seg) ,
    OPERATOR 4 &>(seg,seg) ,
    OPERATOR 5 >>(seg,seg) ,
    OPERATOR 6 =(seg,seg) ,
    OPERATOR 7 @>(seg,seg) ,
    OPERATOR 8 <@(seg,seg) ,
    OPERATOR 13 @(seg,seg) ,
    OPERATOR 14 ~(seg,seg) ,
    FUNCTION 1 gseg_consistent(internal,seg,integer) ,
    FUNCTION 2 gseg_union(internal,internal) ,
    FUNCTION 3 gseg_compress(internal) ,
    FUNCTION 4 gseg_decompress(internal) ,
    FUNCTION 5 gseg_penalty(internal,internal,internal) ,
    FUNCTION 6 gseg_picksplit(internal,internal) ,
    FUNCTION 7 gseg_same(seg,seg,internal);


ALTER OPERATOR CLASS public.gist_seg_ops USING gist OWNER TO postgres;

--
-- TOC entry 2503 (class 2753 OID 18064)
-- Dependencies: 6
-- Name: gist_text_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_text_ops USING gist;


ALTER OPERATOR FAMILY public.gist_text_ops USING gist OWNER TO root;

--
-- TOC entry 2345 (class 2616 OID 18065)
-- Dependencies: 2503 6 1093
-- Name: gist_text_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_text_ops
    DEFAULT FOR TYPE text USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(text,text) ,
    OPERATOR 2 <=(text,text) ,
    OPERATOR 3 =(text,text) ,
    OPERATOR 4 >=(text,text) ,
    OPERATOR 5 >(text,text) ,
    FUNCTION 1 gbt_text_consistent(internal,text,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_text_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_text_ops USING gist OWNER TO postgres;

--
-- TOC entry 2504 (class 2753 OID 18078)
-- Dependencies: 6
-- Name: gist_time_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_time_ops USING gist;


ALTER OPERATOR FAMILY public.gist_time_ops USING gist OWNER TO root;

--
-- TOC entry 2346 (class 2616 OID 18079)
-- Dependencies: 6 1081 2504
-- Name: gist_time_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_time_ops
    DEFAULT FOR TYPE time without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time without time zone,time without time zone) ,
    OPERATOR 2 <=(time without time zone,time without time zone) ,
    OPERATOR 3 =(time without time zone,time without time zone) ,
    OPERATOR 4 >=(time without time zone,time without time zone) ,
    OPERATOR 5 >(time without time zone,time without time zone) ,
    FUNCTION 1 gbt_time_consistent(internal,time without time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_time_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_time_ops USING gist OWNER TO postgres;

--
-- TOC entry 2505 (class 2753 OID 18092)
-- Dependencies: 6
-- Name: gist_timestamp_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_timestamp_ops USING gist;


ALTER OPERATOR FAMILY public.gist_timestamp_ops USING gist OWNER TO root;

--
-- TOC entry 2347 (class 2616 OID 18093)
-- Dependencies: 6 1081 2505
-- Name: gist_timestamp_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timestamp_ops
    DEFAULT FOR TYPE timestamp without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 2 <=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 3 =(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 4 >=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 5 >(timestamp without time zone,timestamp without time zone) ,
    FUNCTION 1 gbt_ts_consistent(internal,timestamp without time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_ts_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamp_ops USING gist OWNER TO postgres;

--
-- TOC entry 2506 (class 2753 OID 18106)
-- Dependencies: 6
-- Name: gist_timestamptz_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_timestamptz_ops USING gist;


ALTER OPERATOR FAMILY public.gist_timestamptz_ops USING gist OWNER TO root;

--
-- TOC entry 2348 (class 2616 OID 18107)
-- Dependencies: 6 1081 2506
-- Name: gist_timestamptz_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timestamptz_ops
    DEFAULT FOR TYPE timestamp with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 2 <=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 3 =(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 4 >=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 5 >(timestamp with time zone,timestamp with time zone) ,
    FUNCTION 1 gbt_tstz_consistent(internal,timestamp with time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_tstz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamptz_ops USING gist OWNER TO postgres;

--
-- TOC entry 2507 (class 2753 OID 18120)
-- Dependencies: 6
-- Name: gist_timetz_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_timetz_ops USING gist;


ALTER OPERATOR FAMILY public.gist_timetz_ops USING gist OWNER TO root;

--
-- TOC entry 2349 (class 2616 OID 18121)
-- Dependencies: 1081 2507 6
-- Name: gist_timetz_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timetz_ops
    DEFAULT FOR TYPE time with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time with time zone,time with time zone) ,
    OPERATOR 2 <=(time with time zone,time with time zone) ,
    OPERATOR 3 =(time with time zone,time with time zone) ,
    OPERATOR 4 >=(time with time zone,time with time zone) ,
    OPERATOR 5 >(time with time zone,time with time zone) ,
    FUNCTION 1 gbt_timetz_consistent(internal,time with time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_timetz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timetz_ops USING gist OWNER TO postgres;

--
-- TOC entry 2508 (class 2753 OID 18134)
-- Dependencies: 6
-- Name: gist_trgm_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_trgm_ops USING gist;


ALTER OPERATOR FAMILY public.gist_trgm_ops USING gist OWNER TO root;

--
-- TOC entry 2350 (class 2616 OID 18135)
-- Dependencies: 1099 2508 6
-- Name: gist_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_trgm_ops
    FOR TYPE text USING gist AS
    STORAGE gtrgm ,
    OPERATOR 1 %(text,text) ,
    FUNCTION 1 gtrgm_consistent(gtrgm,internal,integer) ,
    FUNCTION 2 gtrgm_union(bytea,internal) ,
    FUNCTION 3 gtrgm_compress(internal) ,
    FUNCTION 4 gtrgm_decompress(internal) ,
    FUNCTION 5 gtrgm_penalty(internal,internal,internal) ,
    FUNCTION 6 gtrgm_picksplit(internal,internal) ,
    FUNCTION 7 gtrgm_same(gtrgm,gtrgm,internal);


ALTER OPERATOR CLASS public.gist_trgm_ops USING gist OWNER TO postgres;

--
-- TOC entry 2509 (class 2753 OID 18144)
-- Dependencies: 6
-- Name: gist_vbit_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY gist_vbit_ops USING gist;


ALTER OPERATOR FAMILY public.gist_vbit_ops USING gist OWNER TO root;

--
-- TOC entry 2351 (class 2616 OID 18145)
-- Dependencies: 2509 6 1093
-- Name: gist_vbit_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_vbit_ops
    DEFAULT FOR TYPE bit varying USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit varying,bit varying) ,
    OPERATOR 2 <=(bit varying,bit varying) ,
    OPERATOR 3 =(bit varying,bit varying) ,
    OPERATOR 4 >=(bit varying,bit varying) ,
    OPERATOR 5 >(bit varying,bit varying) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_vbit_ops USING gist OWNER TO postgres;

--
-- TOC entry 2352 (class 2616 OID 18158)
-- Dependencies: 2475 1111 6
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn13,isbn13) ,
    OPERATOR 2 <=(isbn13,isbn13) ,
    OPERATOR 3 =(isbn13,isbn13) ,
    OPERATOR 4 >=(isbn13,isbn13) ,
    OPERATOR 5 >(isbn13,isbn13) ,
    FUNCTION 1 btisbn13cmp(isbn13,isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2353 (class 2616 OID 18165)
-- Dependencies: 1111 2476 6
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn13,isbn13) ,
    FUNCTION 1 hashisbn13(isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2354 (class 2616 OID 18168)
-- Dependencies: 6 2475 1108
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn,isbn) ,
    OPERATOR 2 <=(isbn,isbn) ,
    OPERATOR 3 =(isbn,isbn) ,
    OPERATOR 4 >=(isbn,isbn) ,
    OPERATOR 5 >(isbn,isbn) ,
    FUNCTION 1 btisbncmp(isbn,isbn);


ALTER OPERATOR CLASS public.isbn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2355 (class 2616 OID 18175)
-- Dependencies: 6 2476 1108
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn,isbn) ,
    FUNCTION 1 hashisbn(isbn);


ALTER OPERATOR CLASS public.isbn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2356 (class 2616 OID 18178)
-- Dependencies: 1117 6 2475
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn13,ismn13) ,
    OPERATOR 2 <=(ismn13,ismn13) ,
    OPERATOR 3 =(ismn13,ismn13) ,
    OPERATOR 4 >=(ismn13,ismn13) ,
    OPERATOR 5 >(ismn13,ismn13) ,
    FUNCTION 1 btismn13cmp(ismn13,ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2357 (class 2616 OID 18185)
-- Dependencies: 2476 1117 6
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn13,ismn13) ,
    FUNCTION 1 hashismn13(ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2358 (class 2616 OID 18188)
-- Dependencies: 1114 2475 6
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn,ismn) ,
    OPERATOR 2 <=(ismn,ismn) ,
    OPERATOR 3 =(ismn,ismn) ,
    OPERATOR 4 >=(ismn,ismn) ,
    OPERATOR 5 >(ismn,ismn) ,
    FUNCTION 1 btismncmp(ismn,ismn);


ALTER OPERATOR CLASS public.ismn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2359 (class 2616 OID 18195)
-- Dependencies: 2476 6 1114
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn,ismn) ,
    FUNCTION 1 hashismn(ismn);


ALTER OPERATOR CLASS public.ismn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2360 (class 2616 OID 18198)
-- Dependencies: 1123 2475 6
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn13,issn13) ,
    OPERATOR 2 <=(issn13,issn13) ,
    OPERATOR 3 =(issn13,issn13) ,
    OPERATOR 4 >=(issn13,issn13) ,
    OPERATOR 5 >(issn13,issn13) ,
    FUNCTION 1 btissn13cmp(issn13,issn13);


ALTER OPERATOR CLASS public.issn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2361 (class 2616 OID 18205)
-- Dependencies: 1123 2476 6
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn13,issn13) ,
    FUNCTION 1 hashissn13(issn13);


ALTER OPERATOR CLASS public.issn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2362 (class 2616 OID 18208)
-- Dependencies: 2475 1120 6
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn,issn) ,
    OPERATOR 2 <=(issn,issn) ,
    OPERATOR 3 =(issn,issn) ,
    OPERATOR 4 >=(issn,issn) ,
    OPERATOR 5 >(issn,issn) ,
    FUNCTION 1 btissncmp(issn,issn);


ALTER OPERATOR CLASS public.issn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2363 (class 2616 OID 18215)
-- Dependencies: 6 1120 2476
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn,issn) ,
    FUNCTION 1 hashissn(issn);


ALTER OPERATOR CLASS public.issn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2510 (class 2753 OID 18218)
-- Dependencies: 6
-- Name: ltree_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY ltree_ops USING btree;


ALTER OPERATOR FAMILY public.ltree_ops USING btree OWNER TO root;

--
-- TOC entry 2364 (class 2616 OID 18219)
-- Dependencies: 2510 1130 6
-- Name: ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ltree_ops
    DEFAULT FOR TYPE ltree USING btree AS
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    FUNCTION 1 ltree_cmp(ltree,ltree);


ALTER OPERATOR CLASS public.ltree_ops USING btree OWNER TO postgres;

--
-- TOC entry 2511 (class 2753 OID 18226)
-- Dependencies: 6
-- Name: seg_ops; Type: OPERATOR FAMILY; Schema: public; Owner: root
--

CREATE OPERATOR FAMILY seg_ops USING btree;


ALTER OPERATOR FAMILY public.seg_ops USING btree OWNER TO root;

--
-- TOC entry 2365 (class 2616 OID 18227)
-- Dependencies: 6 1144 2511
-- Name: seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS seg_ops
    DEFAULT FOR TYPE seg USING btree AS
    OPERATOR 1 <(seg,seg) ,
    OPERATOR 2 <=(seg,seg) ,
    OPERATOR 3 =(seg,seg) ,
    OPERATOR 4 >=(seg,seg) ,
    OPERATOR 5 >(seg,seg) ,
    FUNCTION 1 seg_cmp(seg,seg);


ALTER OPERATOR CLASS public.seg_ops USING btree OWNER TO postgres;

--
-- TOC entry 2366 (class 2616 OID 18234)
-- Dependencies: 2475 1155 6
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING btree FAMILY isn_ops AS
    OPERATOR 1 <(upc,upc) ,
    OPERATOR 2 <=(upc,upc) ,
    OPERATOR 3 =(upc,upc) ,
    OPERATOR 4 >=(upc,upc) ,
    OPERATOR 5 >(upc,upc) ,
    FUNCTION 1 btupccmp(upc,upc);


ALTER OPERATOR CLASS public.upc_ops USING btree OWNER TO postgres;

--
-- TOC entry 2367 (class 2616 OID 18241)
-- Dependencies: 2476 1155 6
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING hash FAMILY isn_ops AS
    OPERATOR 1 =(upc,upc) ,
    FUNCTION 1 hashupc(upc);


ALTER OPERATOR CLASS public.upc_ops USING hash OWNER TO postgres;

SET search_path = pg_catalog;

--
-- TOC entry 3107 (class 2605 OID 18244)
-- Dependencies: 435 1072 435 1108
-- Name: CAST (public.ean13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn) WITH FUNCTION public.isbn(public.ean13);


--
-- TOC entry 3108 (class 2605 OID 18245)
-- Dependencies: 436 1072 436 1111
-- Name: CAST (public.ean13 AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn13) WITH FUNCTION public.isbn13(public.ean13);


--
-- TOC entry 3109 (class 2605 OID 18246)
-- Dependencies: 439 439 1114 1072
-- Name: CAST (public.ean13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn) WITH FUNCTION public.ismn(public.ean13);


--
-- TOC entry 3110 (class 2605 OID 18247)
-- Dependencies: 440 1072 440 1117
-- Name: CAST (public.ean13 AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn13) WITH FUNCTION public.ismn13(public.ean13);


--
-- TOC entry 3111 (class 2605 OID 18248)
-- Dependencies: 611 1120 1072 611
-- Name: CAST (public.ean13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn) WITH FUNCTION public.issn(public.ean13);


--
-- TOC entry 3112 (class 2605 OID 18249)
-- Dependencies: 612 1123 1072 612
-- Name: CAST (public.ean13 AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn13) WITH FUNCTION public.issn13(public.ean13);


--
-- TOC entry 3113 (class 2605 OID 18250)
-- Dependencies: 749 1072 1155 749
-- Name: CAST (public.ean13 AS public.upc); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.upc) WITH FUNCTION public.upc(public.ean13);


--
-- TOC entry 3114 (class 2605 OID 18251)
-- Dependencies: 1108 1072
-- Name: CAST (public.isbn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3115 (class 2605 OID 18252)
-- Dependencies: 1111 1108
-- Name: CAST (public.isbn AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.isbn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3116 (class 2605 OID 18253)
-- Dependencies: 1111 1072
-- Name: CAST (public.isbn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3117 (class 2605 OID 18254)
-- Dependencies: 1108 1111
-- Name: CAST (public.isbn13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.isbn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3118 (class 2605 OID 18255)
-- Dependencies: 1072 1114
-- Name: CAST (public.ismn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3119 (class 2605 OID 18256)
-- Dependencies: 1117 1114
-- Name: CAST (public.ismn AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ismn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3120 (class 2605 OID 18257)
-- Dependencies: 1072 1117
-- Name: CAST (public.ismn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3121 (class 2605 OID 18258)
-- Dependencies: 1117 1114
-- Name: CAST (public.ismn13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ismn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3122 (class 2605 OID 18259)
-- Dependencies: 1120 1072
-- Name: CAST (public.issn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3123 (class 2605 OID 18260)
-- Dependencies: 1120 1123
-- Name: CAST (public.issn AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.issn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3124 (class 2605 OID 18261)
-- Dependencies: 1072 1123
-- Name: CAST (public.issn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3125 (class 2605 OID 18262)
-- Dependencies: 1123 1120
-- Name: CAST (public.issn13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.issn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3126 (class 2605 OID 18263)
-- Dependencies: 1072 1155
-- Name: CAST (public.upc AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.upc AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2791 (class 1259 OID 18264)
-- Dependencies: 6
-- Name: areatematica; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE areatematica (
    id integer NOT NULL,
    nombre text NOT NULL,
    descripcion text
);


ALTER TABLE public.areatematica OWNER TO root;

--
-- TOC entry 2792 (class 1259 OID 18270)
-- Dependencies: 2791 6
-- Name: areatematica_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE areatematica_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.areatematica_id_seq OWNER TO root;

--
-- TOC entry 3282 (class 0 OID 0)
-- Dependencies: 2792
-- Name: areatematica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE areatematica_id_seq OWNED BY areatematica.id;


--
-- TOC entry 3283 (class 0 OID 0)
-- Dependencies: 2792
-- Name: areatematica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('areatematica_id_seq', 10, true);


--
-- TOC entry 2793 (class 1259 OID 18272)
-- Dependencies: 3135 6
-- Name: estudiante; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE estudiante (
    cod integer NOT NULL,
    semestre integer DEFAULT 1 NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.estudiante OWNER TO root;

--
-- TOC entry 2794 (class 1259 OID 18276)
-- Dependencies: 6 2793
-- Name: estudiante_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE estudiante_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.estudiante_id_seq OWNER TO root;

--
-- TOC entry 3285 (class 0 OID 0)
-- Dependencies: 2794
-- Name: estudiante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE estudiante_id_seq OWNED BY estudiante.id;


--
-- TOC entry 3286 (class 0 OID 0)
-- Dependencies: 2794
-- Name: estudiante_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('estudiante_id_seq', 26, true);


--
-- TOC entry 2795 (class 1259 OID 18278)
-- Dependencies: 6 2786
-- Name: examen_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE examen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.examen_id_seq OWNER TO root;

--
-- TOC entry 3287 (class 0 OID 0)
-- Dependencies: 2795
-- Name: examen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE examen_id_seq OWNED BY examen.id;


--
-- TOC entry 3288 (class 0 OID 0)
-- Dependencies: 2795
-- Name: examen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('examen_id_seq', 52, true);


--
-- TOC entry 2796 (class 1259 OID 18280)
-- Dependencies: 6
-- Name: imagen; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE imagen (
    id integer NOT NULL,
    url text NOT NULL,
    tamano integer,
    dimencion text
);


ALTER TABLE public.imagen OWNER TO root;

--
-- TOC entry 2797 (class 1259 OID 18286)
-- Dependencies: 2796 6
-- Name: imagen_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE imagen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.imagen_id_seq OWNER TO root;

--
-- TOC entry 3290 (class 0 OID 0)
-- Dependencies: 2797
-- Name: imagen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE imagen_id_seq OWNED BY imagen.id;


--
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 2797
-- Name: imagen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('imagen_id_seq', 1, true);


--
-- TOC entry 2798 (class 1259 OID 18288)
-- Dependencies: 6
-- Name: inscripcionexamen; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE inscripcionexamen (
    examen_id integer NOT NULL,
    estudiante_cod integer NOT NULL,
    fecha date NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.inscripcionexamen OWNER TO root;

--
-- TOC entry 2799 (class 1259 OID 18291)
-- Dependencies: 6 2798
-- Name: inscripcionexamen_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE inscripcionexamen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.inscripcionexamen_id_seq OWNER TO root;

--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 2799
-- Name: inscripcionexamen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE inscripcionexamen_id_seq OWNED BY inscripcionexamen.id;


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 2799
-- Name: inscripcionexamen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('inscripcionexamen_id_seq', 19, true);


--
-- TOC entry 2800 (class 1259 OID 18293)
-- Dependencies: 6
-- Name: jefeprograma; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE jefeprograma (
    cod integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.jefeprograma OWNER TO root;

--
-- TOC entry 2801 (class 1259 OID 18296)
-- Dependencies: 2800 6
-- Name: jefeprograma_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE jefeprograma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jefeprograma_id_seq OWNER TO root;

--
-- TOC entry 3296 (class 0 OID 0)
-- Dependencies: 2801
-- Name: jefeprograma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE jefeprograma_id_seq OWNED BY jefeprograma.id;


--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 2801
-- Name: jefeprograma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('jefeprograma_id_seq', 2, true);


--
-- TOC entry 2802 (class 1259 OID 18298)
-- Dependencies: 3140 6
-- Name: usuario; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE usuario (
    id integer NOT NULL,
    cod integer,
    nombre text NOT NULL,
    p_apellido text,
    s_apellido text,
    user_name text,
    pass text,
    email text,
    fecha_ing date,
    programa_id integer,
    estado boolean DEFAULT true NOT NULL
);


ALTER TABLE public.usuario OWNER TO root;

--
-- TOC entry 2803 (class 1259 OID 18305)
-- Dependencies: 2911 6
-- Name: jefprogram; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW jefprogram AS
    SELECT usuario.cod, usuario.nombre, usuario.p_apellido, usuario.s_apellido, usuario.email, usuario.programa_id FROM usuario, jefeprograma WHERE (usuario.cod = jefeprograma.cod);


ALTER TABLE public.jefprogram OWNER TO root;

--
-- TOC entry 2804 (class 1259 OID 18309)
-- Dependencies: 6
-- Name: profesor; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE profesor (
    cod integer NOT NULL,
    titulo text,
    id integer NOT NULL
);


ALTER TABLE public.profesor OWNER TO root;

--
-- TOC entry 2805 (class 1259 OID 18315)
-- Dependencies: 2912 6
-- Name: masters; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW masters AS
    SELECT usuario.cod, usuario.nombre, usuario.p_apellido, usuario.s_apellido, usuario.email, usuario.programa_id, profesor.titulo FROM usuario, profesor WHERE (usuario.cod = profesor.cod);


ALTER TABLE public.masters OWNER TO root;

--
-- TOC entry 2806 (class 1259 OID 18319)
-- Dependencies: 6
-- Name: oprespuesta; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE oprespuesta (
    pregunta_id integer NOT NULL,
    id integer NOT NULL,
    opcion integer NOT NULL,
    texto text,
    imagen_id integer
);


ALTER TABLE public.oprespuesta OWNER TO root;

--
-- TOC entry 2807 (class 1259 OID 18325)
-- Dependencies: 6 2806
-- Name: oprespuesta_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE oprespuesta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.oprespuesta_id_seq OWNER TO root;

--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 2807
-- Name: oprespuesta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE oprespuesta_id_seq OWNED BY oprespuesta.id;


--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 2807
-- Name: oprespuesta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('oprespuesta_id_seq', 80, true);


--
-- TOC entry 2808 (class 1259 OID 18327)
-- Dependencies: 2913 6
-- Name: pg_buffercache; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW pg_buffercache AS
    SELECT p.bufferid, p.relfilenode, p.reltablespace, p.reldatabase, p.relblocknumber, p.isdirty, p.usagecount FROM pg_buffercache_pages() p(bufferid integer, relfilenode oid, reltablespace oid, reldatabase oid, relblocknumber bigint, isdirty boolean, usagecount smallint);


ALTER TABLE public.pg_buffercache OWNER TO postgres;

--
-- TOC entry 2809 (class 1259 OID 18331)
-- Dependencies: 6 2787
-- Name: pregunta_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE pregunta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pregunta_id_seq OWNER TO root;

--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 2809
-- Name: pregunta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE pregunta_id_seq OWNED BY pregunta.id;


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 2809
-- Name: pregunta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('pregunta_id_seq', 80, true);


--
-- TOC entry 2810 (class 1259 OID 18333)
-- Dependencies: 6
-- Name: preguntaexamen; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE preguntaexamen (
    id integer NOT NULL,
    examen_id integer NOT NULL,
    pregunta_id integer NOT NULL
);


ALTER TABLE public.preguntaexamen OWNER TO root;

--
-- TOC entry 2811 (class 1259 OID 18336)
-- Dependencies: 2810 6
-- Name: preguntaexamen_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE preguntaexamen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.preguntaexamen_id_seq OWNER TO root;

--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 2811
-- Name: preguntaexamen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE preguntaexamen_id_seq OWNED BY preguntaexamen.id;


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 2811
-- Name: preguntaexamen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('preguntaexamen_id_seq', 36, true);


--
-- TOC entry 2812 (class 1259 OID 18338)
-- Dependencies: 6 2804
-- Name: profesor_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE profesor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.profesor_id_seq OWNER TO root;

--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 2812
-- Name: profesor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE profesor_id_seq OWNED BY profesor.id;


--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 2812
-- Name: profesor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('profesor_id_seq', 3, true);


--
-- TOC entry 2813 (class 1259 OID 18340)
-- Dependencies: 6
-- Name: programa; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE programa (
    id integer NOT NULL,
    cod integer NOT NULL,
    nombre text NOT NULL,
    fecha_ingreso date,
    fecha_creacion date
);


ALTER TABLE public.programa OWNER TO root;

--
-- TOC entry 2814 (class 1259 OID 18346)
-- Dependencies: 6 2813
-- Name: programa_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE programa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.programa_id_seq OWNER TO root;

--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 2814
-- Name: programa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE programa_id_seq OWNED BY programa.id;


--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 2814
-- Name: programa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('programa_id_seq', 2, true);


--
-- TOC entry 2815 (class 1259 OID 18348)
-- Dependencies: 2788 6
-- Name: respuesta_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE respuesta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.respuesta_id_seq OWNER TO root;

--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 2815
-- Name: respuesta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE respuesta_id_seq OWNED BY respuesta.id;


--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 2815
-- Name: respuesta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('respuesta_id_seq', 2627, true);


--
-- TOC entry 2816 (class 1259 OID 18350)
-- Dependencies: 2914 6
-- Name: respuestas; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW respuestas AS
    SELECT verdad.id, verdad."TRUE", falso."FALSE" FROM (verdad NATURAL JOIN falso);


ALTER TABLE public.respuestas OWNER TO root;

--
-- TOC entry 2817 (class 1259 OID 18354)
-- Dependencies: 2915 6
-- Name: student; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW student AS
    SELECT usuario.cod, usuario.nombre, usuario.p_apellido, usuario.s_apellido, usuario.email, usuario.programa_id, estudiante.semestre FROM usuario, estudiante WHERE (usuario.cod = estudiante.cod);


ALTER TABLE public.student OWNER TO root;

--
-- TOC entry 2818 (class 1259 OID 18358)
-- Dependencies: 6
-- Name: subarea; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE subarea (
    id integer NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    areatematica_id integer
);


ALTER TABLE public.subarea OWNER TO root;

--
-- TOC entry 2819 (class 1259 OID 18364)
-- Dependencies: 6 2818
-- Name: subarea_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE subarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.subarea_id_seq OWNER TO root;

--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 2819
-- Name: subarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE subarea_id_seq OWNED BY subarea.id;


--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 2819
-- Name: subarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('subarea_id_seq', 14, true);


--
-- TOC entry 2820 (class 1259 OID 18366)
-- Dependencies: 6
-- Name: tipo; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE tipo (
    id integer NOT NULL,
    nombre text NOT NULL,
    numero integer NOT NULL,
    descripcion text
);


ALTER TABLE public.tipo OWNER TO root;

--
-- TOC entry 2821 (class 1259 OID 18372)
-- Dependencies: 6 2820
-- Name: tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tipo_id_seq OWNER TO root;

--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 2821
-- Name: tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE tipo_id_seq OWNED BY tipo.id;


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 2821
-- Name: tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('tipo_id_seq', 8, true);


--
-- TOC entry 2822 (class 1259 OID 18374)
-- Dependencies: 2802 6
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO root;

--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 2822
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 2822
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('usuario_id_seq', 22, true);


--
-- TOC entry 3134 (class 2604 OID 18624)
-- Dependencies: 2792 2791
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE areatematica ALTER COLUMN id SET DEFAULT nextval('areatematica_id_seq'::regclass);


--
-- TOC entry 3136 (class 2604 OID 18625)
-- Dependencies: 2794 2793
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE estudiante ALTER COLUMN id SET DEFAULT nextval('estudiante_id_seq'::regclass);


--
-- TOC entry 3129 (class 2604 OID 18626)
-- Dependencies: 2795 2786
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE examen ALTER COLUMN id SET DEFAULT nextval('examen_id_seq'::regclass);


--
-- TOC entry 3137 (class 2604 OID 18627)
-- Dependencies: 2797 2796
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE imagen ALTER COLUMN id SET DEFAULT nextval('imagen_id_seq'::regclass);


--
-- TOC entry 3138 (class 2604 OID 18628)
-- Dependencies: 2799 2798
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE inscripcionexamen ALTER COLUMN id SET DEFAULT nextval('inscripcionexamen_id_seq'::regclass);


--
-- TOC entry 3139 (class 2604 OID 18629)
-- Dependencies: 2801 2800
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE jefeprograma ALTER COLUMN id SET DEFAULT nextval('jefeprograma_id_seq'::regclass);


--
-- TOC entry 3143 (class 2604 OID 18630)
-- Dependencies: 2807 2806
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE oprespuesta ALTER COLUMN id SET DEFAULT nextval('oprespuesta_id_seq'::regclass);


--
-- TOC entry 3132 (class 2604 OID 18631)
-- Dependencies: 2809 2787
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE pregunta ALTER COLUMN id SET DEFAULT nextval('pregunta_id_seq'::regclass);


--
-- TOC entry 3144 (class 2604 OID 18632)
-- Dependencies: 2811 2810
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE preguntaexamen ALTER COLUMN id SET DEFAULT nextval('preguntaexamen_id_seq'::regclass);


--
-- TOC entry 3142 (class 2604 OID 18633)
-- Dependencies: 2812 2804
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE profesor ALTER COLUMN id SET DEFAULT nextval('profesor_id_seq'::regclass);


--
-- TOC entry 3145 (class 2604 OID 18634)
-- Dependencies: 2814 2813
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE programa ALTER COLUMN id SET DEFAULT nextval('programa_id_seq'::regclass);


--
-- TOC entry 3133 (class 2604 OID 18635)
-- Dependencies: 2815 2788
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE respuesta ALTER COLUMN id SET DEFAULT nextval('respuesta_id_seq'::regclass);


--
-- TOC entry 3146 (class 2604 OID 18636)
-- Dependencies: 2819 2818
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE subarea ALTER COLUMN id SET DEFAULT nextval('subarea_id_seq'::regclass);


--
-- TOC entry 3147 (class 2604 OID 18637)
-- Dependencies: 2821 2820
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE tipo ALTER COLUMN id SET DEFAULT nextval('tipo_id_seq'::regclass);


--
-- TOC entry 3141 (class 2604 OID 18638)
-- Dependencies: 2822 2802
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- TOC entry 3215 (class 0 OID 18264)
-- Dependencies: 2791
-- Data for Name: areatematica; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO areatematica (id, nombre, descripcion) VALUES (2, 'area 2', 'area tematica 2');
INSERT INTO areatematica (id, nombre, descripcion) VALUES (5, 'NOMBRE 5', 'DESCRIPCION 5');
INSERT INTO areatematica (id, nombre, descripcion) VALUES (6, 'NOMBRE 6', 'DESCRIPCION 6');
INSERT INTO areatematica (id, nombre, descripcion) VALUES (1, 'area 1', 'descriccion de area tematica 1');


--
-- TOC entry 3216 (class 0 OID 18272)
-- Dependencies: 2793
-- Data for Name: estudiante; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO estudiante (cod, semestre, id) VALUES (220710010, 1, 5);
INSERT INTO estudiante (cod, semestre, id) VALUES (220710008, 1, 7);
INSERT INTO estudiante (cod, semestre, id) VALUES (220710023, 1, 21);
INSERT INTO estudiante (cod, semestre, id) VALUES (220710002, 4, 23);
INSERT INTO estudiante (cod, semestre, id) VALUES (220710001, 6, 24);
INSERT INTO estudiante (cod, semestre, id) VALUES (15, 6, 26);


--
-- TOC entry 3212 (class 0 OID 16692)
-- Dependencies: 2786
-- Data for Name: examen; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO examen (id, fecha_inicio, fecha_fin, tiempo, estado, programa_id, nombre, descripcion) VALUES (52, '2009-12-03', '2009-12-25', 10, true, 1, 'examen 52', 'descripcion de examen 52');


--
-- TOC entry 3217 (class 0 OID 18280)
-- Dependencies: 2796
-- Data for Name: imagen; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO imagen (id, url, tamano, dimencion) VALUES (1, 'primera', 56, '40x40');


--
-- TOC entry 3218 (class 0 OID 18288)
-- Dependencies: 2798
-- Data for Name: inscripcionexamen; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO inscripcionexamen (examen_id, estudiante_cod, fecha, id) VALUES (52, 220710008, '2009-12-03', 17);
INSERT INTO inscripcionexamen (examen_id, estudiante_cod, fecha, id) VALUES (52, 220710010, '2009-12-03', 18);
INSERT INTO inscripcionexamen (examen_id, estudiante_cod, fecha, id) VALUES (52, 15, '2009-12-03', 19);


--
-- TOC entry 3219 (class 0 OID 18293)
-- Dependencies: 2800
-- Data for Name: jefeprograma; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO jefeprograma (cod, id) VALUES (2009110121, 1);


--
-- TOC entry 3222 (class 0 OID 18319)
-- Dependencies: 2806
-- Data for Name: oprespuesta; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (79, 73, 1, 'lunes ', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (79, 74, 2, 'jueves', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (79, 75, 3, 'miercoles', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (79, 76, 4, 'viernes', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (80, 77, 1, 'barba', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (80, 78, 2, 'barbo', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (80, 79, 3, 'castillo', NULL);
INSERT INTO oprespuesta (pregunta_id, id, opcion, texto, imagen_id) VALUES (80, 80, 4, 'ballesteros', NULL);


--
-- TOC entry 3213 (class 0 OID 16700)
-- Dependencies: 2787
-- Data for Name: pregunta; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO pregunta (id, texto, nivel, clave, tema, tiempo, grupo_id, tipo_id, profesor_cod, imagen_id, subarea_id, areatematica_id) VALUES (79, '¿Que dia es hoy?', 1, 2, 'Cultura', 1, NULL, 2, 2009110122, NULL, 2, 2);
INSERT INTO pregunta (id, texto, nivel, clave, tema, tiempo, grupo_id, tipo_id, profesor_cod, imagen_id, subarea_id, areatematica_id) VALUES (80, '¿Cual es el apellido de oscar?', 1, 4, 'universidad', 1, NULL, 3, 2009110122, NULL, 7, 2);


--
-- TOC entry 3223 (class 0 OID 18333)
-- Dependencies: 2810
-- Data for Name: preguntaexamen; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO preguntaexamen (id, examen_id, pregunta_id) VALUES (35, 52, 79);
INSERT INTO preguntaexamen (id, examen_id, pregunta_id) VALUES (36, 52, 80);


--
-- TOC entry 3221 (class 0 OID 18309)
-- Dependencies: 2804
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO profesor (cod, titulo, id) VALUES (2009110122, 'DEFAULT', 1);
INSERT INTO profesor (cod, titulo, id) VALUES (20082020, 'INGENIERA DE SISTEMAS', 3);


--
-- TOC entry 3224 (class 0 OID 18340)
-- Dependencies: 2813
-- Data for Name: programa; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO programa (id, cod, nombre, fecha_ingreso, fecha_creacion) VALUES (1, 22, 'ingnieria de sistemas', NULL, NULL);
INSERT INTO programa (id, cod, nombre, fecha_ingreso, fecha_creacion) VALUES (2, 25, 'Ingenieria Quimica', NULL, NULL);


--
-- TOC entry 3214 (class 0 OID 16708)
-- Dependencies: 2788
-- Data for Name: respuesta; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2624, 52, 220710010, 79, 2, true);
INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2625, 52, 220710010, 80, 4, true);
INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2626, 52, 15, 79, 1, false);
INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2627, 52, 15, 80, 4, true);
INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2622, 52, 220710008, 79, 2, true);
INSERT INTO respuesta (id, examen_id, estudiante_cod, pregunta_id, seleccion, acertada) VALUES (2623, 52, 220710008, 80, 3, false);


--
-- TOC entry 3225 (class 0 OID 18358)
-- Dependencies: 2818
-- Data for Name: subarea; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (2, 'subarea 2', 'subarea 2', 2);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (3, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (7, 'NOMBREdasdasd', 'DESCRIPCION asdasdasd', 6);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (1, 'subarea1', 'descripcion de la subarea 1', 5);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (8, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (9, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (10, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (11, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (12, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (13, 'NOMBRE', 'DESCRIPCION', 1);
INSERT INTO subarea (id, nombre, descripcion, areatematica_id) VALUES (14, 'NOMBRE', 'DESCRIPCION', 1);


--
-- TOC entry 3226 (class 0 OID 18366)
-- Dependencies: 2820
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (2, 'tipo 2', 2, 'tipo de pregunta 2');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (3, 'tipo 3', 3, 'tipo de pregunta 3');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (5, 'tipo 5', 5, 'tipo de pregunta 5');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (6, 'tipo 6', 6, 'tipo de pregunta 6');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (1, 'tipo 1', 1, 'tipo de pregunta 1');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (4, 'tipo cuatro', 4, 'tipo de pregunta 4');
INSERT INTO tipo (id, nombre, numero, descripcion) VALUES (8, 'NOMBRE', 1, 'DESCRIPCION');


--
-- TOC entry 3220 (class 0 OID 18298)
-- Dependencies: 2802
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (5, 220710010, 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'wqe', '2009-10-22', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (100, 220710008, 'BENJAMIN', 'CASTILLO', 'CASTRO', 'BENLLY', '123456', 'NO@TENGO', '2009-10-22', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (7, 220710051, 'KENNY', 'MARTINEZ', 'HERRERA', 'kenny', '123456', 'no@tengo', '2009-11-23', 1, false);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (1, 2009110122, 'PROFESOR', 'PROFESOR', 'PROFESOR', 'PROFESOR', '123456', 'PROFESOR', '2009-10-10', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (3, 2009110121, 'JEFEPROGRAMA', 'JEFEPROGRAMA
', 'JEFEPROGRAMA
', 'JEFEPROGRAMA
', '123456', 'JEFEPROGRAMA
', '2009-10-10', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (9, 231320, 'juan', NULL, NULL, NULL, NULL, NULL, NULL, 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (12, 220710023, 'juan', NULL, NULL, NULL, NULL, NULL, NULL, 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (15, 220710002, 'LUIS', 'PEREA', 'RAMOS', 'luis', '123', 'noasd', '2009-11-24', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (16, 220710001, 'ARTURO ', 'GONZALEZ', 'VILLAMIZAR', 'milan', '123', 'dedewd', '2009-11-24', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (19, 20082020, 'YASMIN', 'MOLLA', 'VILLA', 'tasmi', '12345', 'dddidjij', '2009-11-24', 1, true);
INSERT INTO usuario (id, cod, nombre, p_apellido, s_apellido, user_name, pass, email, fecha_ing, programa_id, estado) VALUES (22, 15, 'UIHUOIB', 'PIUBPIUNB', 'PIUBPIUNB', 'piuniunb', '123', 'dsrgfds', '2009-12-03', 1, true);


--
-- TOC entry 3159 (class 2606 OID 18392)
-- Dependencies: 2791 2791
-- Name: areatematica_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY areatematica
    ADD CONSTRAINT areatematica_pkey PRIMARY KEY (id);


--
-- TOC entry 3161 (class 2606 OID 18394)
-- Dependencies: 2793 2793
-- Name: estudiante_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY estudiante
    ADD CONSTRAINT estudiante_pkey PRIMARY KEY (cod);


--
-- TOC entry 3149 (class 2606 OID 18396)
-- Dependencies: 2786 2786
-- Name: examen_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY examen
    ADD CONSTRAINT examen_pkey PRIMARY KEY (id);


--
-- TOC entry 3163 (class 2606 OID 18398)
-- Dependencies: 2796 2796
-- Name: imagen_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY imagen
    ADD CONSTRAINT imagen_pkey PRIMARY KEY (id);


--
-- TOC entry 3165 (class 2606 OID 18400)
-- Dependencies: 2798 2798 2798 2798
-- Name: inscripcionexamen_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY inscripcionexamen
    ADD CONSTRAINT inscripcionexamen_pkey PRIMARY KEY (examen_id, estudiante_cod, fecha);


--
-- TOC entry 3167 (class 2606 OID 18402)
-- Dependencies: 2800 2800
-- Name: jefeprograma_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY jefeprograma
    ADD CONSTRAINT jefeprograma_pkey PRIMARY KEY (cod);


--
-- TOC entry 3176 (class 2606 OID 18404)
-- Dependencies: 2806 2806
-- Name: oprespuesta_id_key; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY oprespuesta
    ADD CONSTRAINT oprespuesta_id_key UNIQUE (id);


--
-- TOC entry 3178 (class 2606 OID 18406)
-- Dependencies: 2806 2806 2806
-- Name: oprespuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY oprespuesta
    ADD CONSTRAINT oprespuesta_pkey PRIMARY KEY (pregunta_id, opcion);


--
-- TOC entry 3152 (class 2606 OID 18408)
-- Dependencies: 2787 2787
-- Name: pregunta_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_pkey PRIMARY KEY (id);


--
-- TOC entry 3180 (class 2606 OID 18410)
-- Dependencies: 2810 2810 2810
-- Name: preguntaexamen_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY preguntaexamen
    ADD CONSTRAINT preguntaexamen_pkey PRIMARY KEY (examen_id, pregunta_id);


--
-- TOC entry 3174 (class 2606 OID 18412)
-- Dependencies: 2804 2804
-- Name: profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (cod);


--
-- TOC entry 3182 (class 2606 OID 18414)
-- Dependencies: 2813 2813
-- Name: programa_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT programa_pkey PRIMARY KEY (id);


--
-- TOC entry 3155 (class 2606 OID 18416)
-- Dependencies: 2788 2788 2788 2788
-- Name: respuesta_examen_id_key; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_examen_id_key UNIQUE (examen_id, pregunta_id, estudiante_cod);


--
-- TOC entry 3157 (class 2606 OID 18418)
-- Dependencies: 2788 2788
-- Name: respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_pkey PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 18420)
-- Dependencies: 2818 2818
-- Name: subarea_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY subarea
    ADD CONSTRAINT subarea_pkey PRIMARY KEY (id);


--
-- TOC entry 3186 (class 2606 OID 18422)
-- Dependencies: 2820 2820
-- Name: tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 3170 (class 2606 OID 18424)
-- Dependencies: 2802 2802
-- Name: usuario_cod_key; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_cod_key UNIQUE (cod);


--
-- TOC entry 3172 (class 2606 OID 18426)
-- Dependencies: 2802 2802
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3150 (class 1259 OID 18427)
-- Dependencies: 2787
-- Name: index_pregunta; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE UNIQUE INDEX index_pregunta ON pregunta USING btree (id);


--
-- TOC entry 3153 (class 1259 OID 18428)
-- Dependencies: 2788 2788 2788
-- Name: index_respuesta; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE UNIQUE INDEX index_respuesta ON respuesta USING btree (examen_id, estudiante_cod, pregunta_id);


--
-- TOC entry 3168 (class 1259 OID 18429)
-- Dependencies: 2802
-- Name: index_usuario; Type: INDEX; Schema: public; Owner: root; Tablespace: 
--

CREATE UNIQUE INDEX index_usuario ON usuario USING btree (cod);


--
-- TOC entry 3208 (class 2620 OID 18430)
-- Dependencies: 2788 624
-- Name: califica; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER califica
    AFTER INSERT ON respuesta
    FOR EACH ROW
    EXECUTE PROCEDURE llena_acertada();


--
-- TOC entry 3209 (class 2620 OID 18431)
-- Dependencies: 667 2793
-- Name: norepeat_cod; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER norepeat_cod
    BEFORE INSERT OR UPDATE ON estudiante
    FOR EACH ROW
    EXECUTE PROCEDURE no_repeat();


--
-- TOC entry 3210 (class 2620 OID 18432)
-- Dependencies: 667 2800
-- Name: veificacod; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER veificacod
    BEFORE INSERT OR UPDATE ON jefeprograma
    FOR EACH ROW
    EXECUTE PROCEDURE no_repeat();


--
-- TOC entry 3211 (class 2620 OID 18433)
-- Dependencies: 667 2804
-- Name: verificacod; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER verificacod
    BEFORE INSERT OR UPDATE ON profesor
    FOR EACH ROW
    EXECUTE PROCEDURE no_repeat();


--
-- TOC entry 3197 (class 2606 OID 18434)
-- Dependencies: 2793 2802 3169
-- Name: estudiante_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY estudiante
    ADD CONSTRAINT estudiante_cod_fkey FOREIGN KEY (cod) REFERENCES usuario(cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3187 (class 2606 OID 18439)
-- Dependencies: 2786 3181 2813
-- Name: examen_programa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY examen
    ADD CONSTRAINT examen_programa_id_fkey FOREIGN KEY (programa_id) REFERENCES programa(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- TOC entry 3198 (class 2606 OID 18444)
-- Dependencies: 3160 2798 2793
-- Name: inscripcionexamen_estudiante_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY inscripcionexamen
    ADD CONSTRAINT inscripcionexamen_estudiante_cod_fkey FOREIGN KEY (estudiante_cod) REFERENCES estudiante(cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3199 (class 2606 OID 18449)
-- Dependencies: 2786 2798 3148
-- Name: inscripcionexamen_examen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY inscripcionexamen
    ADD CONSTRAINT inscripcionexamen_examen_id_fkey FOREIGN KEY (examen_id) REFERENCES examen(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3200 (class 2606 OID 18454)
-- Dependencies: 2800 3169 2802
-- Name: jefeprograma_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY jefeprograma
    ADD CONSTRAINT jefeprograma_cod_fkey FOREIGN KEY (cod) REFERENCES usuario(cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3203 (class 2606 OID 18459)
-- Dependencies: 2806 3162 2796
-- Name: oprespuesta_imagen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY oprespuesta
    ADD CONSTRAINT oprespuesta_imagen_id_fkey FOREIGN KEY (imagen_id) REFERENCES imagen(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3204 (class 2606 OID 18464)
-- Dependencies: 3151 2787 2806
-- Name: oprespuesta_pregunta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY oprespuesta
    ADD CONSTRAINT oprespuesta_pregunta_id_fkey FOREIGN KEY (pregunta_id) REFERENCES pregunta(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3188 (class 2606 OID 18469)
-- Dependencies: 2787 3158 2791
-- Name: pregunta_areatematica_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_areatematica_id_fkey FOREIGN KEY (areatematica_id) REFERENCES areatematica(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3189 (class 2606 OID 18474)
-- Dependencies: 2796 3162 2787
-- Name: pregunta_imagen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_imagen_id_fkey FOREIGN KEY (imagen_id) REFERENCES imagen(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3190 (class 2606 OID 18479)
-- Dependencies: 2787 3173 2804
-- Name: pregunta_profesor_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_profesor_cod_fkey FOREIGN KEY (profesor_cod) REFERENCES profesor(cod) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- TOC entry 3191 (class 2606 OID 18484)
-- Dependencies: 3183 2818 2787
-- Name: pregunta_subarea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_subarea_id_fkey FOREIGN KEY (subarea_id) REFERENCES subarea(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- TOC entry 3192 (class 2606 OID 18489)
-- Dependencies: 3185 2820 2787
-- Name: pregunta_tipo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pregunta
    ADD CONSTRAINT pregunta_tipo_id_fkey FOREIGN KEY (tipo_id) REFERENCES tipo(id) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- TOC entry 3205 (class 2606 OID 18494)
-- Dependencies: 3148 2810 2786
-- Name: preguntaexamen_examen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY preguntaexamen
    ADD CONSTRAINT preguntaexamen_examen_id_fkey FOREIGN KEY (examen_id) REFERENCES examen(id);


--
-- TOC entry 3206 (class 2606 OID 18499)
-- Dependencies: 2787 2810 3151
-- Name: preguntaexamen_pregunta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY preguntaexamen
    ADD CONSTRAINT preguntaexamen_pregunta_id_fkey FOREIGN KEY (pregunta_id) REFERENCES pregunta(id);


--
-- TOC entry 3202 (class 2606 OID 18504)
-- Dependencies: 2802 3169 2804
-- Name: profesor_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_cod_fkey FOREIGN KEY (cod) REFERENCES usuario(cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3193 (class 2606 OID 18509)
-- Dependencies: 2788 3160 2793
-- Name: respuesta_estudiante_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_estudiante_cod_fkey FOREIGN KEY (estudiante_cod) REFERENCES estudiante(cod) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3194 (class 2606 OID 18514)
-- Dependencies: 3160 2788 2793
-- Name: respuesta_estudiante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_estudiante_id_fkey FOREIGN KEY (estudiante_cod) REFERENCES estudiante(cod);


--
-- TOC entry 3195 (class 2606 OID 18519)
-- Dependencies: 2786 3148 2788
-- Name: respuesta_examen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_examen_id_fkey FOREIGN KEY (examen_id) REFERENCES examen(id);


--
-- TOC entry 3196 (class 2606 OID 18524)
-- Dependencies: 3151 2787 2788
-- Name: respuesta_pregunta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY respuesta
    ADD CONSTRAINT respuesta_pregunta_id_fkey FOREIGN KEY (pregunta_id) REFERENCES pregunta(id);


--
-- TOC entry 3207 (class 2606 OID 18529)
-- Dependencies: 2791 2818 3158
-- Name: subarea_areatematica_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY subarea
    ADD CONSTRAINT subarea_areatematica_id_fkey FOREIGN KEY (areatematica_id) REFERENCES areatematica(id);


--
-- TOC entry 3201 (class 2606 OID 18534)
-- Dependencies: 3181 2802 2813
-- Name: usuario_programa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_programa_id_fkey FOREIGN KEY (programa_id) REFERENCES programa(id);


--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO root;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3260 (class 0 OID 0)
-- Dependencies: 776
-- Name: dblink_connect_u(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM postgres;
GRANT ALL ON FUNCTION dblink_connect_u(text) TO postgres;


--
-- TOC entry 3261 (class 0 OID 0)
-- Dependencies: 226
-- Name: dblink_connect_u(text, text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM postgres;
GRANT ALL ON FUNCTION dblink_connect_u(text, text) TO postgres;


--
-- TOC entry 3262 (class 0 OID 0)
-- Dependencies: 2786
-- Name: examen; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE examen FROM PUBLIC;
REVOKE ALL ON TABLE examen FROM root;
GRANT ALL ON TABLE examen TO root;
GRANT ALL ON TABLE examen TO PUBLIC;


--
-- TOC entry 3263 (class 0 OID 0)
-- Dependencies: 2787
-- Name: pregunta; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE pregunta FROM PUBLIC;
REVOKE ALL ON TABLE pregunta FROM root;
GRANT ALL ON TABLE pregunta TO root;
GRANT ALL ON TABLE pregunta TO PUBLIC;


--
-- TOC entry 3264 (class 0 OID 0)
-- Dependencies: 2788
-- Name: respuesta; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE respuesta FROM PUBLIC;
REVOKE ALL ON TABLE respuesta FROM root;
GRANT ALL ON TABLE respuesta TO root;
GRANT ALL ON TABLE respuesta TO PUBLIC;


--
-- TOC entry 3265 (class 0 OID 0)
-- Dependencies: 775
-- Name: pg_buffercache_pages(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM PUBLIC;
REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM postgres;
GRANT ALL ON FUNCTION pg_buffercache_pages() TO postgres;


--
-- TOC entry 3281 (class 0 OID 0)
-- Dependencies: 2791
-- Name: areatematica; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE areatematica FROM PUBLIC;
REVOKE ALL ON TABLE areatematica FROM root;
GRANT ALL ON TABLE areatematica TO root;
GRANT ALL ON TABLE areatematica TO PUBLIC;


--
-- TOC entry 3284 (class 0 OID 0)
-- Dependencies: 2793
-- Name: estudiante; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE estudiante FROM PUBLIC;
REVOKE ALL ON TABLE estudiante FROM root;
GRANT ALL ON TABLE estudiante TO root;
GRANT ALL ON TABLE estudiante TO PUBLIC;


--
-- TOC entry 3289 (class 0 OID 0)
-- Dependencies: 2796
-- Name: imagen; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE imagen FROM PUBLIC;
REVOKE ALL ON TABLE imagen FROM root;
GRANT ALL ON TABLE imagen TO root;
GRANT ALL ON TABLE imagen TO PUBLIC;


--
-- TOC entry 3292 (class 0 OID 0)
-- Dependencies: 2798
-- Name: inscripcionexamen; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE inscripcionexamen FROM PUBLIC;
REVOKE ALL ON TABLE inscripcionexamen FROM root;
GRANT ALL ON TABLE inscripcionexamen TO root;
GRANT ALL ON TABLE inscripcionexamen TO PUBLIC;


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 2800
-- Name: jefeprograma; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE jefeprograma FROM PUBLIC;
REVOKE ALL ON TABLE jefeprograma FROM root;
GRANT ALL ON TABLE jefeprograma TO root;
GRANT ALL ON TABLE jefeprograma TO PUBLIC;


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 2802
-- Name: usuario; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE usuario FROM PUBLIC;
REVOKE ALL ON TABLE usuario FROM root;
GRANT ALL ON TABLE usuario TO root;
GRANT ALL ON TABLE usuario TO PUBLIC;


--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 2804
-- Name: profesor; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE profesor FROM PUBLIC;
REVOKE ALL ON TABLE profesor FROM root;
GRANT ALL ON TABLE profesor TO root;
GRANT ALL ON TABLE profesor TO PUBLIC;


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 2806
-- Name: oprespuesta; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE oprespuesta FROM PUBLIC;
REVOKE ALL ON TABLE oprespuesta FROM root;
GRANT ALL ON TABLE oprespuesta TO root;
GRANT ALL ON TABLE oprespuesta TO PUBLIC;


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 2808
-- Name: pg_buffercache; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pg_buffercache FROM PUBLIC;
REVOKE ALL ON TABLE pg_buffercache FROM postgres;
GRANT ALL ON TABLE pg_buffercache TO postgres;


--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 2813
-- Name: programa; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE programa FROM PUBLIC;
REVOKE ALL ON TABLE programa FROM root;
GRANT ALL ON TABLE programa TO root;
GRANT ALL ON TABLE programa TO PUBLIC;


--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 2818
-- Name: subarea; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE subarea FROM PUBLIC;
REVOKE ALL ON TABLE subarea FROM root;
GRANT ALL ON TABLE subarea TO root;
GRANT ALL ON TABLE subarea TO PUBLIC;


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 2820
-- Name: tipo; Type: ACL; Schema: public; Owner: root
--

REVOKE ALL ON TABLE tipo FROM PUBLIC;
REVOKE ALL ON TABLE tipo FROM root;
GRANT ALL ON TABLE tipo TO root;
GRANT ALL ON TABLE tipo TO PUBLIC;


-- Completed on 2009-12-03 20:31:23

--
-- PostgreSQL database dump complete
--

