select json_arrayagg (option_r returning VARCHAR(50 )) from options;

select json_arrayagg (option_r returning VARCHAR(50 )) from options;

select json_arrayagg (option_r returning BLOB SUB_TYPE TEXT) from options;

select json_arrayagg (option_r returning BLOB) from options;