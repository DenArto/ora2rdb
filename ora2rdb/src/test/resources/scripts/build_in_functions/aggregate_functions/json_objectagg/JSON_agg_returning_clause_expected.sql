select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING VARCHAR(50)) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING VARCHAR(50 )) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING VARCHAR(50 )) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING BLOB SUB_TYPE TEXT) from options;
select JSON_OBJECTAGG (KEY option_r VALUE id RETURNING blob) from options;