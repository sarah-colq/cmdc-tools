import pandas as pd
import us

from ...base import DatasetBaseNoDate
from ..base import ArcGIS


class Hawaii(DatasetBaseNoDate, ArcGIS):

    ARCGIS_ID = "aKxrz4vDVjfUwBWJ"
    state_fips = int(us.states.lookup("Hawaii").fips)
    has_fips = False
    source = "https://hiema-hub.hawaii.gov/"

    def get(self):
        cases = self._get_cases()
        testing = self._get_testing()

        df = pd.concat([testing, cases], axis=0).sort_values(["dt", "county"])
        df["vintage"] = self._retrieve_vintage()

        return df


    def _get_cases(self):
        df = self.get_all_sheet_to_df("HIEMA_COVID_DATA_LATEST", 0, "9")
        renamed = df.rename(
            columns={
                "name": "county",
                "toDate_positiveAndPresumed": "cases_total",
                "toDate_fatalities": "deaths_total"
            }
        )
        keep_rows = ["Hawaii", "Honolulu", "Kauai", "Maui"]
        renamed["dt"] = self._retrieve_dt("US/Hawaii")
        renamed = renamed.loc[renamed.county.isin(keep_rows)]
        return (
            renamed[["county", "dt", "cases_total", "deaths_total"]]
            .melt(id_vars=["dt", "county"], var_name="variable_name")
        )

    def _get_testing(self):
        df = self.get_all_sheet_to_df("HIEMA_TEST_DATA_LATEST", 0, "9")
        renamed = df.rename(
            columns={
                "name": "county",
                "postive_rate": "test_positivity"  # There's a spelling error in the db
            }
        )
        keep_rows = ["Hawaii", "Honolulu", "Kauai", "Maui"]
        renamed["dt"] = self._retrieve_dt("US/Hawaii")
        renamed = renamed.loc[renamed.county.isin(keep_rows)]
        return (
            renamed[["county", "dt", "test_positivity"]]
            .melt(id_vars=["dt", "county"], var_name="variable_name")
        )


