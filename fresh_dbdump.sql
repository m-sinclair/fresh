--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE activity (
    id text NOT NULL,
    "timestamp" timestamp without time zone,
    user_id text,
    object_id text,
    revision_id text,
    activity_type text,
    data text
);


ALTER TABLE public.activity OWNER TO fresh;

--
-- Name: activity_detail; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE activity_detail (
    id text NOT NULL,
    activity_id text,
    object_id text,
    object_type text,
    activity_type text,
    data text
);


ALTER TABLE public.activity_detail OWNER TO fresh;

--
-- Name: authorization_group; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE authorization_group (
    id text NOT NULL,
    name text,
    created timestamp without time zone
);


ALTER TABLE public.authorization_group OWNER TO fresh;

--
-- Name: authorization_group_role; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE authorization_group_role (
    user_object_role_id text NOT NULL,
    authorization_group_id text
);


ALTER TABLE public.authorization_group_role OWNER TO fresh;

--
-- Name: authorization_group_user; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE authorization_group_user (
    authorization_group_id text NOT NULL,
    user_id text NOT NULL,
    id text NOT NULL
);


ALTER TABLE public.authorization_group_user OWNER TO fresh;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE dashboard (
    user_id text NOT NULL,
    activity_stream_last_viewed timestamp without time zone NOT NULL,
    email_last_sent timestamp without time zone DEFAULT ('now'::text)::timestamp without time zone NOT NULL
);


ALTER TABLE public.dashboard OWNER TO fresh;

--
-- Name: group; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE "group" (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp without time zone,
    state text,
    revision_id text,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


ALTER TABLE public."group" OWNER TO fresh;

--
-- Name: group_extra; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE group_extra (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text,
    revision_id text
);


ALTER TABLE public.group_extra OWNER TO fresh;

--
-- Name: group_extra_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE group_extra_revision (
    id text NOT NULL,
    group_id text,
    key text,
    value text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.group_extra_revision OWNER TO fresh;

--
-- Name: group_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE group_revision (
    id text NOT NULL,
    name text NOT NULL,
    title text,
    description text,
    created timestamp without time zone,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    type text NOT NULL,
    approval_status text,
    image_url text,
    is_organization boolean DEFAULT false
);


ALTER TABLE public.group_revision OWNER TO fresh;

--
-- Name: group_role; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE group_role (
    user_object_role_id text NOT NULL,
    group_id text
);


ALTER TABLE public.group_role OWNER TO fresh;

--
-- Name: member; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE member (
    id text NOT NULL,
    table_id text NOT NULL,
    group_id text,
    state text,
    revision_id text,
    table_name text NOT NULL,
    capacity text NOT NULL
);


ALTER TABLE public.member OWNER TO fresh;

--
-- Name: member_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE member_revision (
    id text NOT NULL,
    table_id text NOT NULL,
    group_id text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    table_name text NOT NULL,
    capacity text NOT NULL
);


ALTER TABLE public.member_revision OWNER TO fresh;

--
-- Name: migrate_version; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE migrate_version (
    repository_id character varying(250) NOT NULL,
    repository_path text,
    version integer
);


ALTER TABLE public.migrate_version OWNER TO fresh;

--
-- Name: package; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    license_id text,
    revision_id text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    state text,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp without time zone,
    creator_user_id text
);


ALTER TABLE public.package OWNER TO fresh;

--
-- Name: package_extra; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_extra (
    id text NOT NULL,
    package_id text,
    key text,
    value text,
    revision_id text,
    state text
);


ALTER TABLE public.package_extra OWNER TO fresh;

--
-- Name: package_extra_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_extra_revision (
    id text NOT NULL,
    package_id text,
    key text,
    value text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_extra_revision OWNER TO fresh;

--
-- Name: package_relationship; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_relationship (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    revision_id text,
    state text
);


ALTER TABLE public.package_relationship OWNER TO fresh;

--
-- Name: package_relationship_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_relationship_revision (
    id text NOT NULL,
    subject_package_id text,
    object_package_id text,
    type text,
    comment text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_relationship_revision OWNER TO fresh;

--
-- Name: package_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_revision (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    title text,
    version character varying(100),
    url text,
    notes text,
    license_id text,
    revision_id text NOT NULL,
    continuity_id text,
    author text,
    author_email text,
    maintainer text,
    maintainer_email text,
    state text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    type text,
    owner_org text,
    private boolean DEFAULT false,
    metadata_modified timestamp without time zone,
    creator_user_id text
);


ALTER TABLE public.package_revision OWNER TO fresh;

--
-- Name: package_role; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_role (
    user_object_role_id text NOT NULL,
    package_id text
);


ALTER TABLE public.package_role OWNER TO fresh;

--
-- Name: package_tag; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_tag (
    id text NOT NULL,
    package_id text,
    tag_id text,
    revision_id text,
    state text
);


ALTER TABLE public.package_tag OWNER TO fresh;

--
-- Name: package_tag_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE package_tag_revision (
    id text NOT NULL,
    package_id text,
    tag_id text,
    revision_id text NOT NULL,
    continuity_id text,
    state text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.package_tag_revision OWNER TO fresh;

--
-- Name: rating; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE rating (
    id text NOT NULL,
    user_id text,
    user_ip_address text,
    package_id text,
    rating double precision,
    created timestamp without time zone
);


ALTER TABLE public.rating OWNER TO fresh;

--
-- Name: related; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE related (
    id text NOT NULL,
    type text NOT NULL,
    title text,
    description text,
    image_url text,
    url text,
    created timestamp without time zone,
    owner_id text,
    view_count integer DEFAULT 0 NOT NULL,
    featured integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.related OWNER TO fresh;

--
-- Name: related_dataset; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE related_dataset (
    id text NOT NULL,
    dataset_id text NOT NULL,
    related_id text NOT NULL,
    status text
);


ALTER TABLE public.related_dataset OWNER TO fresh;

--
-- Name: resource; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE resource (
    id text NOT NULL,
    resource_group_id text,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    revision_id text,
    hash text,
    state text,
    extras text,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp without time zone,
    cache_url text,
    cache_last_updated timestamp without time zone,
    webstore_url text,
    webstore_last_updated timestamp without time zone,
    created timestamp without time zone,
    url_type text
);


ALTER TABLE public.resource OWNER TO fresh;

--
-- Name: resource_group; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE resource_group (
    id text NOT NULL,
    package_id text,
    label text,
    sort_order text,
    extras text,
    state text,
    revision_id text
);


ALTER TABLE public.resource_group OWNER TO fresh;

--
-- Name: resource_group_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE resource_group_revision (
    id text NOT NULL,
    package_id text,
    label text,
    sort_order text,
    extras text,
    state text,
    revision_id text NOT NULL,
    continuity_id text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean
);


ALTER TABLE public.resource_group_revision OWNER TO fresh;

--
-- Name: resource_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE resource_revision (
    id text NOT NULL,
    resource_group_id text,
    url text NOT NULL,
    format text,
    description text,
    "position" integer,
    revision_id text NOT NULL,
    continuity_id text,
    hash text,
    state text,
    extras text,
    expired_id text,
    revision_timestamp timestamp without time zone,
    expired_timestamp timestamp without time zone,
    current boolean,
    name text,
    resource_type text,
    mimetype text,
    mimetype_inner text,
    size bigint,
    last_modified timestamp without time zone,
    cache_url text,
    cache_last_updated timestamp without time zone,
    webstore_url text,
    webstore_last_updated timestamp without time zone,
    created timestamp without time zone,
    url_type text
);


ALTER TABLE public.resource_revision OWNER TO fresh;

--
-- Name: revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE revision (
    id text NOT NULL,
    "timestamp" timestamp without time zone,
    author character varying(200),
    message text,
    state text,
    approved_timestamp timestamp without time zone
);


ALTER TABLE public.revision OWNER TO fresh;

--
-- Name: role_action; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE role_action (
    id text NOT NULL,
    role text,
    context text NOT NULL,
    action text
);


ALTER TABLE public.role_action OWNER TO fresh;

--
-- Name: system_info; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE system_info (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    revision_id text
);


ALTER TABLE public.system_info OWNER TO fresh;

--
-- Name: system_info_id_seq; Type: SEQUENCE; Schema: public; Owner: fresh
--

CREATE SEQUENCE system_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_info_id_seq OWNER TO fresh;

--
-- Name: system_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fresh
--

ALTER SEQUENCE system_info_id_seq OWNED BY system_info.id;


--
-- Name: system_info_revision; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE system_info_revision (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value text,
    revision_id text NOT NULL,
    continuity_id integer
);


ALTER TABLE public.system_info_revision OWNER TO fresh;

--
-- Name: system_info_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: fresh
--

CREATE SEQUENCE system_info_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_info_revision_id_seq OWNER TO fresh;

--
-- Name: system_info_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fresh
--

ALTER SEQUENCE system_info_revision_id_seq OWNED BY system_info_revision.id;


--
-- Name: system_role; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE system_role (
    user_object_role_id text NOT NULL
);


ALTER TABLE public.system_role OWNER TO fresh;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE tag (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    vocabulary_id character varying(100)
);


ALTER TABLE public.tag OWNER TO fresh;

--
-- Name: task_status; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE task_status (
    id text NOT NULL,
    entity_id text NOT NULL,
    entity_type text NOT NULL,
    task_type text NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    state text,
    error text,
    last_updated timestamp without time zone
);


ALTER TABLE public.task_status OWNER TO fresh;

--
-- Name: term_translation; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE term_translation (
    term text NOT NULL,
    term_translation text NOT NULL,
    lang_code text NOT NULL
);


ALTER TABLE public.term_translation OWNER TO fresh;

--
-- Name: tracking_raw; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE tracking_raw (
    user_key character varying(100) NOT NULL,
    url text NOT NULL,
    tracking_type character varying(10) NOT NULL,
    access_timestamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tracking_raw OWNER TO fresh;

--
-- Name: tracking_summary; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE tracking_summary (
    url text NOT NULL,
    package_id text,
    tracking_type character varying(10) NOT NULL,
    count integer NOT NULL,
    running_total integer DEFAULT 0 NOT NULL,
    recent_views integer DEFAULT 0 NOT NULL,
    tracking_date date
);


ALTER TABLE public.tracking_summary OWNER TO fresh;

--
-- Name: user; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE "user" (
    id text NOT NULL,
    name text NOT NULL,
    apikey text,
    created timestamp without time zone,
    about text,
    openid text,
    password text,
    fullname text,
    email text,
    reset_key text,
    sysadmin boolean DEFAULT false,
    activity_streams_email_notifications boolean DEFAULT false,
    state text DEFAULT 'active'::text NOT NULL
);


ALTER TABLE public."user" OWNER TO fresh;

--
-- Name: user_following_dataset; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE user_following_dataset (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_dataset OWNER TO fresh;

--
-- Name: user_following_group; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE user_following_group (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_group OWNER TO fresh;

--
-- Name: user_following_user; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE user_following_user (
    follower_id text NOT NULL,
    object_id text NOT NULL,
    datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.user_following_user OWNER TO fresh;

--
-- Name: user_object_role; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE user_object_role (
    id text NOT NULL,
    user_id text,
    context text NOT NULL,
    role text,
    authorized_group_id text
);


ALTER TABLE public.user_object_role OWNER TO fresh;

--
-- Name: vocabulary; Type: TABLE; Schema: public; Owner: fresh; Tablespace: 
--

CREATE TABLE vocabulary (
    id text NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.vocabulary OWNER TO fresh;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_info ALTER COLUMN id SET DEFAULT nextval('system_info_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_info_revision ALTER COLUMN id SET DEFAULT nextval('system_info_revision_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY activity (id, "timestamp", user_id, object_id, revision_id, activity_type, data) FROM stdin;
\.


--
-- Data for Name: activity_detail; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY activity_detail (id, activity_id, object_id, object_type, activity_type, data) FROM stdin;
\.


--
-- Data for Name: authorization_group; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY authorization_group (id, name, created) FROM stdin;
\.


--
-- Data for Name: authorization_group_role; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY authorization_group_role (user_object_role_id, authorization_group_id) FROM stdin;
\.


--
-- Data for Name: authorization_group_user; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY authorization_group_user (authorization_group_id, user_id, id) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY dashboard (user_id, activity_stream_last_viewed, email_last_sent) FROM stdin;
fe1df539-ae39-4e37-a2d8-12d167b7cde9	2014-04-23 16:34:19.349384	2014-04-23 16:34:19.308392
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY "group" (id, name, title, description, created, state, revision_id, type, approval_status, image_url, is_organization) FROM stdin;
\.


--
-- Data for Name: group_extra; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY group_extra (id, group_id, key, value, state, revision_id) FROM stdin;
\.


--
-- Data for Name: group_extra_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY group_extra_revision (id, group_id, key, value, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: group_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY group_revision (id, name, title, description, created, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, type, approval_status, image_url, is_organization) FROM stdin;
\.


--
-- Data for Name: group_role; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY group_role (user_object_role_id, group_id) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY member (id, table_id, group_id, state, revision_id, table_name, capacity) FROM stdin;
\.


--
-- Data for Name: member_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY member_revision (id, table_id, group_id, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current, table_name, capacity) FROM stdin;
\.


--
-- Data for Name: migrate_version; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY migrate_version (repository_id, repository_path, version) FROM stdin;
Ckan	/usr/lib/ckan/fresh/src/ckan/ckan/migration	71
\.


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package (id, name, title, version, url, notes, license_id, revision_id, author, author_email, maintainer, maintainer_email, state, type, owner_org, private, metadata_modified, creator_user_id) FROM stdin;
\.


--
-- Data for Name: package_extra; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_extra (id, package_id, key, value, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_extra_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_extra_revision (id, package_id, key, value, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_relationship; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_relationship (id, subject_package_id, object_package_id, type, comment, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_relationship_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_relationship_revision (id, subject_package_id, object_package_id, type, comment, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: package_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_revision (id, name, title, version, url, notes, license_id, revision_id, continuity_id, author, author_email, maintainer, maintainer_email, state, expired_id, revision_timestamp, expired_timestamp, current, type, owner_org, private, metadata_modified, creator_user_id) FROM stdin;
\.


--
-- Data for Name: package_role; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_role (user_object_role_id, package_id) FROM stdin;
\.


--
-- Data for Name: package_tag; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_tag (id, package_id, tag_id, revision_id, state) FROM stdin;
\.


--
-- Data for Name: package_tag_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY package_tag_revision (id, package_id, tag_id, revision_id, continuity_id, state, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY rating (id, user_id, user_ip_address, package_id, rating, created) FROM stdin;
\.


--
-- Data for Name: related; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY related (id, type, title, description, image_url, url, created, owner_id, view_count, featured) FROM stdin;
\.


--
-- Data for Name: related_dataset; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY related_dataset (id, dataset_id, related_id, status) FROM stdin;
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY resource (id, resource_group_id, url, format, description, "position", revision_id, hash, state, extras, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type) FROM stdin;
\.


--
-- Data for Name: resource_group; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY resource_group (id, package_id, label, sort_order, extras, state, revision_id) FROM stdin;
\.


--
-- Data for Name: resource_group_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY resource_group_revision (id, package_id, label, sort_order, extras, state, revision_id, continuity_id, expired_id, revision_timestamp, expired_timestamp, current) FROM stdin;
\.


--
-- Data for Name: resource_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY resource_revision (id, resource_group_id, url, format, description, "position", revision_id, continuity_id, hash, state, extras, expired_id, revision_timestamp, expired_timestamp, current, name, resource_type, mimetype, mimetype_inner, size, last_modified, cache_url, cache_last_updated, webstore_url, webstore_last_updated, created, url_type) FROM stdin;
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY revision (id, "timestamp", author, message, state, approved_timestamp) FROM stdin;
07d8876e-95a3-465c-9d00-18697d3ec3be	2014-04-23 21:28:27.819224	system	Add versioning to groups, group_extras and package_groups	active	2014-04-23 21:28:27.819224
13244329-dd2c-4774-92e8-c08ffe441f2f	2014-04-23 21:28:28.335879	admin	Admin: make sure every object has a row in a revision table	active	2014-04-23 21:28:28.335879
\.


--
-- Data for Name: role_action; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY role_action (id, role, context, action) FROM stdin;
a06c48a4-d61b-4d36-b600-4ec74f56c74a	editor		read-site
45499159-5f96-4504-a4e7-ce013f54fac2	editor		read-user
1d430e69-64f8-4c66-81d9-08b6515e9ec2	editor		create-user
8eed62ed-625b-480d-8f0f-52f715cf3362	reader		read-site
bf2a1aad-c88e-4eb3-8fc8-a801e925494e	reader		read-user
5bb8cd78-a647-46f3-9640-c288e2a99a22	reader		create-user
eeeee959-7fb1-438f-944a-6ab73b965607	editor		edit
4559efe1-c263-461b-b30c-18af89bc5610	editor		create-package
356bf564-5a05-4961-a831-e80037e18b1f	editor		create-group
bf77812d-f5db-44b5-ac5a-d0ed11bead11	editor		read
48128e78-024f-4edc-a196-67332d935a57	editor		file-upload
3fbf4805-4a98-4b6b-b24e-a98077cf0bb3	anon_editor		edit
088f103f-c0d2-4483-91fe-6c50c0d1d760	anon_editor		create-package
824dfc7e-de17-4e19-b02d-4cebe56c8ff3	anon_editor		create-user
85a02ffa-e1be-4fbc-823f-100cbe872481	anon_editor		read-user
8de89e10-b012-4cb3-a8d0-06977f3bf845	anon_editor		read-site
a565826d-f5f1-4c8f-8c45-6830c105f990	anon_editor		read
8bc7ab54-1c04-4302-b65f-86375468bb06	anon_editor		file-upload
985065a6-d36c-476c-b6ed-6a889baff87d	reader		read
\.


--
-- Data for Name: system_info; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY system_info (id, key, value, revision_id) FROM stdin;
\.


--
-- Name: system_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fresh
--

SELECT pg_catalog.setval('system_info_id_seq', 1, false);


--
-- Data for Name: system_info_revision; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY system_info_revision (id, key, value, revision_id, continuity_id) FROM stdin;
\.


--
-- Name: system_info_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fresh
--

SELECT pg_catalog.setval('system_info_revision_id_seq', 1, false);


--
-- Data for Name: system_role; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY system_role (user_object_role_id) FROM stdin;
a64ba04c-f706-48a8-af8c-259c2903e4d8
73731921-0f65-438e-b1d4-149c8635cb46
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY tag (id, name, vocabulary_id) FROM stdin;
\.


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY task_status (id, entity_id, entity_type, task_type, key, value, state, error, last_updated) FROM stdin;
\.


--
-- Data for Name: term_translation; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY term_translation (term, term_translation, lang_code) FROM stdin;
\.


--
-- Data for Name: tracking_raw; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY tracking_raw (user_key, url, tracking_type, access_timestamp) FROM stdin;
\.


--
-- Data for Name: tracking_summary; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY tracking_summary (url, package_id, tracking_type, count, running_total, recent_views, tracking_date) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY "user" (id, name, apikey, created, about, openid, password, fullname, email, reset_key, sysadmin, activity_streams_email_notifications, state) FROM stdin;
e8821e85-d450-4296-9bc4-8e2574d27c7c	logged_in	4849ac36-b560-4a36-b4ae-3d1cfc904a92	2014-04-23 14:28:30.224144	\N	\N	\N	\N	\N	\N	f	f	active
49516920-4450-4eb8-9437-b798dd48af4c	visitor	a59edc04-990c-484f-9826-55a8a9889334	2014-04-23 14:28:30.226499	\N	\N	\N	\N	\N	\N	f	f	active
cd543af6-703b-44a3-b063-d8013d652549	fresh	2fdfb48e-20b0-4d68-94d8-0e208facaf1b	2014-04-23 14:28:31.846089	\N	\N	8757328f799a6eaaebf4cc1af5d71c9a2032e711b73625171a29d40de82d7e53d008b25fca425386	\N	\N	\N	t	f	active
fe1df539-ae39-4e37-a2d8-12d167b7cde9	admin	c563f4c2-7c5d-4168-bc15-8f4d81ef46e9	2014-04-23 16:33:08.61668	\N	\N	6261d832064dd614c2b644fe40d1dc1cda4731aade3722ee726719bc3462a109fcf133b4de3e99d6	\N	\N	\N	t	f	active
\.


--
-- Data for Name: user_following_dataset; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY user_following_dataset (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_group; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY user_following_group (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_following_user; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY user_following_user (follower_id, object_id, datetime) FROM stdin;
\.


--
-- Data for Name: user_object_role; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY user_object_role (id, user_id, context, role, authorized_group_id) FROM stdin;
a64ba04c-f706-48a8-af8c-259c2903e4d8	49516920-4450-4eb8-9437-b798dd48af4c	System	reader	\N
73731921-0f65-438e-b1d4-149c8635cb46	e8821e85-d450-4296-9bc4-8e2574d27c7c	System	editor	\N
\.


--
-- Data for Name: vocabulary; Type: TABLE DATA; Schema: public; Owner: fresh
--

COPY vocabulary (id, name) FROM stdin;
\.


--
-- Name: activity_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY activity_detail
    ADD CONSTRAINT activity_detail_pkey PRIMARY KEY (id);


--
-- Name: activity_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- Name: authorization_group_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY authorization_group
    ADD CONSTRAINT authorization_group_pkey PRIMARY KEY (id);


--
-- Name: authorization_group_role_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY authorization_group_role
    ADD CONSTRAINT authorization_group_role_pkey PRIMARY KEY (user_object_role_id);


--
-- Name: authorization_group_user_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY authorization_group_user
    ADD CONSTRAINT authorization_group_user_pkey PRIMARY KEY (id);


--
-- Name: dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (user_id);


--
-- Name: group_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY group_extra
    ADD CONSTRAINT group_extra_pkey PRIMARY KEY (id);


--
-- Name: group_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY group_extra_revision
    ADD CONSTRAINT group_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: group_name_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_name_key UNIQUE (name);


--
-- Name: group_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: group_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY group_revision
    ADD CONSTRAINT group_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: group_role_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY group_role
    ADD CONSTRAINT group_role_pkey PRIMARY KEY (user_object_role_id);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: member_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY member_revision
    ADD CONSTRAINT member_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: migrate_version_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY migrate_version
    ADD CONSTRAINT migrate_version_pkey PRIMARY KEY (repository_id);


--
-- Name: package_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_extra
    ADD CONSTRAINT package_extra_pkey PRIMARY KEY (id);


--
-- Name: package_extra_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_extra_revision
    ADD CONSTRAINT package_extra_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_name_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package
    ADD CONSTRAINT package_name_key UNIQUE (name);


--
-- Name: package_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package
    ADD CONSTRAINT package_pkey PRIMARY KEY (id);


--
-- Name: package_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_relationship
    ADD CONSTRAINT package_relationship_pkey PRIMARY KEY (id);


--
-- Name: package_relationship_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_revision
    ADD CONSTRAINT package_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: package_role_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_role
    ADD CONSTRAINT package_role_pkey PRIMARY KEY (user_object_role_id);


--
-- Name: package_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_tag
    ADD CONSTRAINT package_tag_pkey PRIMARY KEY (id);


--
-- Name: package_tag_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY package_tag_revision
    ADD CONSTRAINT package_tag_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: rating_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY rating
    ADD CONSTRAINT rating_pkey PRIMARY KEY (id);


--
-- Name: related_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY related_dataset
    ADD CONSTRAINT related_dataset_pkey PRIMARY KEY (id);


--
-- Name: related_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY related
    ADD CONSTRAINT related_pkey PRIMARY KEY (id);


--
-- Name: resource_group_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY resource_group
    ADD CONSTRAINT resource_group_pkey PRIMARY KEY (id);


--
-- Name: resource_group_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY resource_group_revision
    ADD CONSTRAINT resource_group_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: resource_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- Name: resource_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY resource_revision
    ADD CONSTRAINT resource_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT revision_pkey PRIMARY KEY (id);


--
-- Name: role_action_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY role_action
    ADD CONSTRAINT role_action_pkey PRIMARY KEY (id);


--
-- Name: system_info_key_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY system_info
    ADD CONSTRAINT system_info_key_key UNIQUE (key);


--
-- Name: system_info_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY system_info
    ADD CONSTRAINT system_info_pkey PRIMARY KEY (id);


--
-- Name: system_info_revision_key_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY system_info_revision
    ADD CONSTRAINT system_info_revision_key_key UNIQUE (key);


--
-- Name: system_info_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY system_info_revision
    ADD CONSTRAINT system_info_revision_pkey PRIMARY KEY (id, revision_id);


--
-- Name: system_role_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (user_object_role_id);


--
-- Name: tag_name_vocabulary_id_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_name_vocabulary_id_key UNIQUE (name, vocabulary_id);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: task_status_entity_id_task_type_key_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY task_status
    ADD CONSTRAINT task_status_entity_id_task_type_key_key UNIQUE (entity_id, task_type, key);


--
-- Name: task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (id);


--
-- Name: user_following_dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY user_following_dataset
    ADD CONSTRAINT user_following_dataset_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_group_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY user_following_group
    ADD CONSTRAINT user_following_group_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_following_user_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY user_following_user
    ADD CONSTRAINT user_following_user_pkey PRIMARY KEY (follower_id, object_id);


--
-- Name: user_name_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_name_key UNIQUE (name);


--
-- Name: user_object_role_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY user_object_role
    ADD CONSTRAINT user_object_role_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: vocabulary_name_key; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY vocabulary
    ADD CONSTRAINT vocabulary_name_key UNIQUE (name);


--
-- Name: vocabulary_pkey; Type: CONSTRAINT; Schema: public; Owner: fresh; Tablespace: 
--

ALTER TABLE ONLY vocabulary
    ADD CONSTRAINT vocabulary_pkey PRIMARY KEY (id);


--
-- Name: idx_activity_detail_activity_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_activity_detail_activity_id ON activity_detail USING btree (activity_id);


--
-- Name: idx_activity_object_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_activity_object_id ON activity USING btree (object_id, "timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_activity_user_id ON activity USING btree (user_id, "timestamp");


--
-- Name: idx_extra_grp_id_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_extra_grp_id_pkg_id ON member USING btree (group_id, table_id);


--
-- Name: idx_extra_id_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_extra_id_pkg_id ON package_extra USING btree (id, package_id);


--
-- Name: idx_extra_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_extra_pkg_id ON package_extra USING btree (package_id);


--
-- Name: idx_group_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_current ON group_revision USING btree (current);


--
-- Name: idx_group_extra_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_extra_current ON group_extra_revision USING btree (current);


--
-- Name: idx_group_extra_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_extra_period ON group_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_extra_period_group; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_extra_period_group ON group_extra_revision USING btree (revision_timestamp, expired_timestamp, group_id);


--
-- Name: idx_group_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_id ON "group" USING btree (id);


--
-- Name: idx_group_name; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_name ON "group" USING btree (name);


--
-- Name: idx_group_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_period ON group_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_group_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_group_pkg_id ON member USING btree (table_id);


--
-- Name: idx_openid; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_openid ON "user" USING btree (openid);


--
-- Name: idx_package_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_current ON package_revision USING btree (current);


--
-- Name: idx_package_extra_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_extra_current ON package_extra_revision USING btree (current);


--
-- Name: idx_package_extra_package_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_extra_package_id ON package_extra_revision USING btree (package_id, current);


--
-- Name: idx_package_extra_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_extra_period ON package_extra_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_extra_period_package; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_extra_period_package ON package_extra_revision USING btree (revision_timestamp, expired_timestamp, package_id);


--
-- Name: idx_package_extra_rev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_extra_rev_id ON package_extra_revision USING btree (revision_id);


--
-- Name: idx_package_group_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_current ON member_revision USING btree (current);


--
-- Name: idx_package_group_group_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_group_id ON member USING btree (group_id);


--
-- Name: idx_package_group_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_id ON member USING btree (id);


--
-- Name: idx_package_group_period_package_group; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_period_package_group ON member_revision USING btree (revision_timestamp, expired_timestamp, table_id, group_id);


--
-- Name: idx_package_group_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_pkg_id ON member USING btree (table_id);


--
-- Name: idx_package_group_pkg_id_group_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_group_pkg_id_group_id ON member USING btree (group_id, table_id);


--
-- Name: idx_package_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_period ON package_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_package_relationship_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_relationship_current ON package_relationship_revision USING btree (current);


--
-- Name: idx_package_resource_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_resource_id ON resource USING btree (id);


--
-- Name: idx_package_resource_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_resource_pkg_id ON resource USING btree (resource_group_id);


--
-- Name: idx_package_resource_pkg_id_resource_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_resource_pkg_id_resource_id ON resource USING btree (resource_group_id, id);


--
-- Name: idx_package_resource_rev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_resource_rev_id ON resource_revision USING btree (revision_id);


--
-- Name: idx_package_resource_url; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_resource_url ON resource USING btree (url);


--
-- Name: idx_package_tag_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_current ON package_tag_revision USING btree (current);


--
-- Name: idx_package_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_id ON package_tag USING btree (id);


--
-- Name: idx_package_tag_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_pkg_id ON package_tag USING btree (package_id);


--
-- Name: idx_package_tag_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_pkg_id_tag_id ON package_tag USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_revision_id ON package_tag_revision USING btree (id);


--
-- Name: idx_package_tag_revision_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_revision_pkg_id ON package_tag_revision USING btree (package_id);


--
-- Name: idx_package_tag_revision_pkg_id_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_revision_pkg_id_tag_id ON package_tag_revision USING btree (tag_id, package_id);


--
-- Name: idx_package_tag_revision_rev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_revision_rev_id ON package_tag_revision USING btree (revision_id);


--
-- Name: idx_package_tag_revision_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_revision_tag_id ON package_tag_revision USING btree (tag_id);


--
-- Name: idx_package_tag_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_package_tag_tag_id ON package_tag USING btree (tag_id);


--
-- Name: idx_period_package_relationship; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_period_package_relationship ON package_relationship_revision USING btree (revision_timestamp, expired_timestamp, object_package_id, subject_package_id);


--
-- Name: idx_period_package_tag; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_period_package_tag ON package_tag_revision USING btree (revision_timestamp, expired_timestamp, package_id, tag_id);


--
-- Name: idx_pkg_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_id ON package USING btree (id);


--
-- Name: idx_pkg_lname; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_lname ON package USING btree (lower((name)::text));


--
-- Name: idx_pkg_name; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_name ON package USING btree (name);


--
-- Name: idx_pkg_rev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_rev_id ON package USING btree (revision_id);


--
-- Name: idx_pkg_revision_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_revision_id ON package_revision USING btree (id);


--
-- Name: idx_pkg_revision_name; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_revision_name ON package_revision USING btree (name);


--
-- Name: idx_pkg_revision_rev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_revision_rev_id ON package_revision USING btree (revision_id);


--
-- Name: idx_pkg_sid; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_sid ON package USING btree (id, state);


--
-- Name: idx_pkg_slname; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_slname ON package USING btree (lower((name)::text), state);


--
-- Name: idx_pkg_sname; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_sname ON package USING btree (name, state);


--
-- Name: idx_pkg_srev_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_srev_id ON package USING btree (revision_id, state);


--
-- Name: idx_pkg_stitle; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_stitle ON package USING btree (title, state);


--
-- Name: idx_pkg_suname; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_suname ON package USING btree (upper((name)::text), state);


--
-- Name: idx_pkg_title; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_title ON package USING btree (title);


--
-- Name: idx_pkg_uname; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_pkg_uname ON package USING btree (upper((name)::text));


--
-- Name: idx_ra_action; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_ra_action ON role_action USING btree (action);


--
-- Name: idx_ra_role; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_ra_role ON role_action USING btree (role);


--
-- Name: idx_ra_role_action; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_ra_role_action ON role_action USING btree (action, role);


--
-- Name: idx_rating_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_rating_id ON rating USING btree (id);


--
-- Name: idx_rating_package_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_rating_package_id ON rating USING btree (package_id);


--
-- Name: idx_rating_user_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_rating_user_id ON rating USING btree (user_id);


--
-- Name: idx_resource_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_current ON resource_revision USING btree (current);


--
-- Name: idx_resource_group_current; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_group_current ON resource_group_revision USING btree (current);


--
-- Name: idx_resource_group_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_group_period ON resource_group_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_resource_group_period_package; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_group_period_package ON resource_group_revision USING btree (revision_timestamp, expired_timestamp, package_id);


--
-- Name: idx_resource_period; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_period ON resource_revision USING btree (revision_timestamp, expired_timestamp, id);


--
-- Name: idx_resource_period_resource_group; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_period_resource_group ON resource_revision USING btree (revision_timestamp, expired_timestamp, resource_group_id);


--
-- Name: idx_resource_resource_group_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_resource_resource_group_id ON resource_revision USING btree (resource_group_id, current);


--
-- Name: idx_rev_state; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_rev_state ON revision USING btree (state);


--
-- Name: idx_revision_author; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_revision_author ON revision USING btree (author);


--
-- Name: idx_tag_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_tag_id ON tag USING btree (id);


--
-- Name: idx_tag_name; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_tag_name ON tag USING btree (name);


--
-- Name: idx_uor_context; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_uor_context ON user_object_role USING btree (context);


--
-- Name: idx_uor_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_uor_id ON user_object_role USING btree (id);


--
-- Name: idx_uor_role; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_uor_role ON user_object_role USING btree (role);


--
-- Name: idx_uor_user_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_uor_user_id ON user_object_role USING btree (user_id);


--
-- Name: idx_uor_user_id_role; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_uor_user_id_role ON user_object_role USING btree (user_id, role);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_user_id ON "user" USING btree (id);


--
-- Name: idx_user_name; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_user_name ON "user" USING btree (name);


--
-- Name: idx_user_name_index; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX idx_user_name_index ON "user" USING btree ((CASE WHEN ((fullname IS NULL) OR (fullname = ''::text)) THEN name ELSE fullname END));


--
-- Name: term; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX term ON term_translation USING btree (term);


--
-- Name: term_lang; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX term_lang ON term_translation USING btree (term, lang_code);


--
-- Name: tracking_raw_access_timestamp; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_raw_access_timestamp ON tracking_raw USING btree (access_timestamp);


--
-- Name: tracking_raw_url; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_raw_url ON tracking_raw USING btree (url);


--
-- Name: tracking_raw_user_key; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_raw_user_key ON tracking_raw USING btree (user_key);


--
-- Name: tracking_summary_date; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_summary_date ON tracking_summary USING btree (tracking_date);


--
-- Name: tracking_summary_package_id; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_summary_package_id ON tracking_summary USING btree (package_id);


--
-- Name: tracking_summary_url; Type: INDEX; Schema: public; Owner: fresh; Tablespace: 
--

CREATE INDEX tracking_summary_url ON tracking_summary USING btree (url);


--
-- Name: activity_detail_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY activity_detail
    ADD CONSTRAINT activity_detail_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES activity(id);


--
-- Name: authorization_group_role_authorization_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY authorization_group_role
    ADD CONSTRAINT authorization_group_role_authorization_group_id_fkey FOREIGN KEY (authorization_group_id) REFERENCES authorization_group(id);


--
-- Name: authorization_group_role_user_object_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY authorization_group_role
    ADD CONSTRAINT authorization_group_role_user_object_role_id_fkey FOREIGN KEY (user_object_role_id) REFERENCES user_object_role(id);


--
-- Name: authorization_group_user_authorization_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY authorization_group_user
    ADD CONSTRAINT authorization_group_user_authorization_group_id_fkey FOREIGN KEY (authorization_group_id) REFERENCES authorization_group(id);


--
-- Name: authorization_group_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY authorization_group_user
    ADD CONSTRAINT authorization_group_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: dashboard_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY dashboard
    ADD CONSTRAINT dashboard_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_extra_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_extra
    ADD CONSTRAINT group_extra_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: group_extra_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_extra_revision
    ADD CONSTRAINT group_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES group_extra(id);


--
-- Name: group_extra_revision_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_extra_revision
    ADD CONSTRAINT group_extra_revision_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: group_extra_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_extra
    ADD CONSTRAINT group_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: group_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_extra_revision
    ADD CONSTRAINT group_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: group_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_revision
    ADD CONSTRAINT group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES "group"(id);


--
-- Name: group_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY "group"
    ADD CONSTRAINT group_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: group_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_revision
    ADD CONSTRAINT group_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: group_role_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_role
    ADD CONSTRAINT group_role_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: group_role_user_object_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY group_role
    ADD CONSTRAINT group_role_user_object_role_id_fkey FOREIGN KEY (user_object_role_id) REFERENCES user_object_role(id);


--
-- Name: member_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: member_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY member_revision
    ADD CONSTRAINT member_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES member(id);


--
-- Name: member_revision_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY member_revision
    ADD CONSTRAINT member_revision_group_id_fkey FOREIGN KEY (group_id) REFERENCES "group"(id);


--
-- Name: member_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: member_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY member_revision
    ADD CONSTRAINT member_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_extra_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_extra
    ADD CONSTRAINT package_extra_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: package_extra_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_extra_revision
    ADD CONSTRAINT package_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_extra(id);


--
-- Name: package_extra_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_extra
    ADD CONSTRAINT package_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_extra_revision_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_extra_revision
    ADD CONSTRAINT package_extra_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: package_extra_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_extra_revision
    ADD CONSTRAINT package_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_relationship_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship
    ADD CONSTRAINT package_relationship_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES package(id);


--
-- Name: package_relationship_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_relationship(id);


--
-- Name: package_relationship_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship
    ADD CONSTRAINT package_relationship_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_relationship_revision_object_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_object_package_id_fkey FOREIGN KEY (object_package_id) REFERENCES package(id);


--
-- Name: package_relationship_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_relationship_revision_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship_revision
    ADD CONSTRAINT package_relationship_revision_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES package(id);


--
-- Name: package_relationship_subject_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_relationship
    ADD CONSTRAINT package_relationship_subject_package_id_fkey FOREIGN KEY (subject_package_id) REFERENCES package(id);


--
-- Name: package_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_revision
    ADD CONSTRAINT package_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package(id);


--
-- Name: package_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package
    ADD CONSTRAINT package_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_revision
    ADD CONSTRAINT package_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_role_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_role
    ADD CONSTRAINT package_role_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: package_role_user_object_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_role
    ADD CONSTRAINT package_role_user_object_role_id_fkey FOREIGN KEY (user_object_role_id) REFERENCES user_object_role(id);


--
-- Name: package_tag_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag
    ADD CONSTRAINT package_tag_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: package_tag_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag_revision
    ADD CONSTRAINT package_tag_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_tag(id);


--
-- Name: package_tag_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag
    ADD CONSTRAINT package_tag_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_tag_revision_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag_revision
    ADD CONSTRAINT package_tag_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: package_tag_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag_revision
    ADD CONSTRAINT package_tag_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: package_tag_revision_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag_revision
    ADD CONSTRAINT package_tag_revision_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tag(id);


--
-- Name: package_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY package_tag
    ADD CONSTRAINT package_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tag(id);


--
-- Name: rating_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY rating
    ADD CONSTRAINT rating_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: rating_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY rating
    ADD CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: related_dataset_dataset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY related_dataset
    ADD CONSTRAINT related_dataset_dataset_id_fkey FOREIGN KEY (dataset_id) REFERENCES package(id);


--
-- Name: related_dataset_related_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY related_dataset
    ADD CONSTRAINT related_dataset_related_id_fkey FOREIGN KEY (related_id) REFERENCES related(id);


--
-- Name: resource_group_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_group
    ADD CONSTRAINT resource_group_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: resource_group_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_group_revision
    ADD CONSTRAINT resource_group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES resource_group(id);


--
-- Name: resource_group_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_group
    ADD CONSTRAINT resource_group_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: resource_group_revision_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_group_revision
    ADD CONSTRAINT resource_group_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);


--
-- Name: resource_group_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_group_revision
    ADD CONSTRAINT resource_group_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: resource_resource_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_resource_group_id_fkey FOREIGN KEY (resource_group_id) REFERENCES resource_group(id);


--
-- Name: resource_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_revision
    ADD CONSTRAINT resource_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES resource(id);


--
-- Name: resource_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT resource_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: resource_revision_resource_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_revision
    ADD CONSTRAINT resource_revision_resource_group_id_fkey FOREIGN KEY (resource_group_id) REFERENCES resource_group(id);


--
-- Name: resource_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY resource_revision
    ADD CONSTRAINT resource_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: system_info_revision_continuity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_info_revision
    ADD CONSTRAINT system_info_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES system_info(id);


--
-- Name: system_info_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_info
    ADD CONSTRAINT system_info_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: system_info_revision_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_info_revision
    ADD CONSTRAINT system_info_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


--
-- Name: system_role_user_object_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_user_object_role_id_fkey FOREIGN KEY (user_object_role_id) REFERENCES user_object_role(id);


--
-- Name: tag_vocabulary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_vocabulary_id_fkey FOREIGN KEY (vocabulary_id) REFERENCES vocabulary(id);


--
-- Name: user_following_dataset_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_dataset
    ADD CONSTRAINT user_following_dataset_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_dataset_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_dataset
    ADD CONSTRAINT user_following_dataset_object_id_fkey FOREIGN KEY (object_id) REFERENCES package(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_group
    ADD CONSTRAINT user_following_group_group_id_fkey FOREIGN KEY (object_id) REFERENCES "group"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_group_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_group
    ADD CONSTRAINT user_following_group_user_id_fkey FOREIGN KEY (follower_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user_follower_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_user
    ADD CONSTRAINT user_following_user_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_following_user_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_following_user
    ADD CONSTRAINT user_following_user_object_id_fkey FOREIGN KEY (object_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_object_role_authorized_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_object_role
    ADD CONSTRAINT user_object_role_authorized_group_id_fkey FOREIGN KEY (authorized_group_id) REFERENCES authorization_group(id);


--
-- Name: user_object_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fresh
--

ALTER TABLE ONLY user_object_role
    ADD CONSTRAINT user_object_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

