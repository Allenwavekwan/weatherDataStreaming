cfg:.j.k raze read0 `:config.json;
cfg[`agg_num]: `long$cfg[`aggregate_period_sec]%cfg[`frequency_sec];
t:([]location:();datetime:`datetime$();temperature:`float$();description:());
tg:([]datetime:`datetime$();avg_temp_global:`float$();avg_temp_diff_global:`float$());

agg_weather_global:{[]
 tt:select from t where datetime >= ({@[x;count[x]-cfg`agg_num]};datetime) fby location;
 datetime:exec `datetime$avg datetime from count[cfg`locations] sublist tt;
 avg_temp_global:exec avg temperature from tt;
 avg_temp_diff_global:avg_temp_global-0^exec last avg_temp_global from tg;
 `tg upsert d:`datetime`avg_temp_global`avg_temp_diff_global!(datetime;avg_temp_global;avg_temp_diff_global);
 .j.j d
 };

seed:0;
fs:hsym `$(first system["pwd"]),"/weatherDataGlobal.txt";
fs 0: ();
fh:hopen fs;
h:hopen `::7010;
.z.ts:{
 seed+:1;
 if[0=seed mod cfg[`aggregate_period_sec];`t upsert h ({(neg x)sublist t};100*count cfg`locations);neg[fh] 0N! raze agg_weather_global[]];
 };
system "t 1000";
/read0 fs
