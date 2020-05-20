DROP TABLE IF EXISTS data.cex_state_lex;

CREATE TABLE data.cex_state_lex (
    "date" date,
    "s_prev" smallint references data.us_states(fips),
    "s_today" smallint references data.us_states(fips),
    "lex" numeric(10, 8),
    PRIMARY KEY ("date", "s_prev", "s_today")
);

COMMENT ON TABLE data.cex_state_lex IS E'Among smartphones that pinged in a given state today, what share of those devices pinged in each state at least once during the previous 14 days? The daily state-level LEX is a 51-by-51 matrix in which each cell reports, among devices that pinged today in the column state, the share of devices that pinged in the row state at least once during the previous 14 days. It is important to note that a cell phone can ping in more than a single state which means that these shares will not necessarily sum to 1.

This index is produced by Victor Couture, Jonathan Dingel, Allison Green, Jessie Handbury, and Kevin Williams with assistance from Hayden Parsley and Serena Xu. They are derived from anonymized, aggregated smartphone movement data provided by PlaceIQ. We are grateful to the authors and to PlaceIQ for making this data available to us.

If you use this dataset, we recommend seeing the [notes for users of the LEX dataset](https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/documentation/LEX_notes.md) and [LEX documentation](https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/documentation/LEX.pdf) produced by the original authors.

Source: https://github.com/COVIDExposureIndices/COVIDExposureIndices';

COMMENT ON COLUMN data.cex_state_lex.s_prev IS E'The state for which a device was found in the previous 14 days.';

COMMENT ON COLUMN data.cex_state_lex.s_today IS E'The state for which a device was found on the given date';

COMMENT ON COLUMN data.cex_state_lex.lex IS E'The LEX number';

COMMENT ON COLUMN data.cex_state_lex. "date" IS E'The date for which the data applies';

DROP TABLE IF EXISTS data.cex_county_lex;

CREATE TABLE data.cex_county_lex (
    "date" DATE,
    "c_prev" INT references data.us_counties(fips),
    "c_today" INT references data.us_counties(fips),
    "lex" numeric(10, 8),
    PRIMARY KEY ("date", "c_prev", "c_today")
);

COMMENT ON TABLE data.cex_county_lex IS E'Among smartphones that pinged in a given county today, what share of those devices pinged in each county at least once during the previous 14 days? The daily county-level LEX is an approximately 2000-by-2000 matrix in which each cell reports, among devices that pinged today in the column county, the share of devices that pinged in the row county at least once during the previous 14 days. It is important to note that a cell phone can ping in more than a single county which means that these shares will not necessarily sum to 1.

This index is produced by Victor Couture, Jonathan Dingel, Allison Green, Jessie Handbury, and Kevin Williams with assistance from Hayden Parsley and Serena Xu. They are derived from anonymized, aggregated smartphone movement data provided by PlaceIQ. We are grateful to the authors and to PlaceIQ for making this data available to us.

If you use this dataset, we recommend seeing the [notes for users of the LEX dataset](https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/documentation/LEX_notes.md) and [LEX documentation](https://github.com/COVIDExposureIndices/COVIDExposureIndices/blob/master/documentation/LEX.pdf) produced by the original authors.

Source: https://github.com/COVIDExposureIndices/COVIDExposureIndices';

COMMENT ON COLUMN data.cex_county_lex.c_prev IS E'Each county for which a device was found in the previous 14 days';

COMMENT ON COLUMN data.cex_county_lex.c_today IS E'The county for which a device was found on the given date';

COMMENT ON COLUMN data.cex_county_lex.lex IS E'The LEX number';

COMMENT ON COLUMN data.cex_county_lex."date" IS E'The date for which the data applies';
