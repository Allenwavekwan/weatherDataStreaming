cfg:.j.k raze read0 `:config.json;
cfg[`agg_num]: `long$cfg[`aggregate_period_sec]%cfg[`frequency_sec];
t:([]location:();datetime:`datetime$();temperature:`float$();description:());

location_weather:{[l;k]
 dt:.z.Z;
 data:.j.k first system "./j.sh ", l," ", k;
 d:`location`datetime!(l;dt);
 d[`temperature]:data[`main][`temp];
 d[`description]:exec first description from data[`weather];
 `t upsert d
 };

agg_weather:{[l]
 tt:(neg cfg[`agg_num]) sublist select from t where location like l;
 dt:exec first datetime from tt;
 d:`location`datetime!(l;dt);
 if[cfg[`agg_num]>count tt;:d];
 d[`avg_temp]:exec avg temperature from tt;
 d[`temp_diff]:exec last[temperature]-first temperature from tt;
 mode:{where c=max c:count each group x};
 d[`desc]:exec first mode description from tt;
 .j.j d
 };

seed:0;
fs:hsym `$(first system["pwd"]),"/weatherData.txt";
fs 0: ();
fh:hopen fs;
.z.ts:{
 seed+:1;
 if[0=seed mod cfg[`frequency_sec];location_weather[;cfg`api_key] each cfg`locations];
 if[0=seed mod cfg[`aggregate_period_sec];neg[fh] 0N! raze agg_weather each cfg`locations];
 };
system "t 1000";
/read0 fs
