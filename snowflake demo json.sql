-- json file
create or replace file format my_json
TYPE = JSON
STRIP_OUTER_ARRAY = TRUE;

create or replace table Content(
data variant
);

copy into Content
from @DEMO.PUBLIC.MY_INT_STAGE/Exam-Json-Data.json
file_format = (format_name = 'my_json') ;

select data:id, data:type, data:name, data:ppu, f1.value:id, f1.value:type, f2.value:id, f2.value:type
from Content,
lateral flatten (input=>data:batters.batter) as f1,
lateral flatten (input=>data:topping) as f2;




--json file

create or replace table Content1(
data variant
);

copy into Content1
from @DEMO.PUBLIC.MY_INT_STAGE/nutrition_tweets.json
file_format = (format_name = 'my_json') ;

select data:created_at, f1.value:text, f1.value:indices, f2.value:screen_name, f3.value:hashtags.indicates
from Content1,
lateral flatten (input=>data:entities.hashtags) as f1,
lateral flatten (input=>data:entities.user_mentions) as f2,
lateral flatten (input=>data:retweeted_status.entities) as f3;

select data:created_at, f1.value:indices[0], f1.value:indices[1], f1.value:text, f2.value:id, f2.value:id_str, f2.value:indices[0], f2.value:indices[1], f2.value:name, f2.value:screen_name, data:metadata.iso_language_code, data:metadata.result_type, data:retweeted_status.created_at, f3.value:indices[0], f3.value:indices[1], f3.value:text, f4.value:display_url, f4.value:expanded_url,
f4.value:indices[0], f4.value:indices[1], f4.value:url, data:retweeted_status.metadata.iso_language_code, data:retweeted_status.metadata.result_type, data:user.created_at, f5.value:display_url, f5.value:expanded_url
from Content1,
lateral flatten (input=>data:entities.hashtags) as f1,
lateral flatten (input=>data:entities.user_mentions) as f2,
lateral flatten (input=>data:retweeted_status.entities.hashtags) as f3,
lateral flatten (input=>data:retweeted_status.entities.urls) as f4,
lateral flatten (input=>data:user.entities.url.urls) as f5;

select data from content1;


