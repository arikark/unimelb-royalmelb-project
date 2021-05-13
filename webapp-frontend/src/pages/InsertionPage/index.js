import React, { useEffect, useState } from "react";

import { Container } from "@material-ui/core";
import axios from "axios";
import { useSnackbar } from "notistack";
import Dropdown from "../../components/Dropdown";
import FieldInsert from "../../components/FieldInsert";
import { useAuthStateContext } from "../../context/authProvider";

const InsertionPage = () => {
  const [tableWithFields, setTableWithFields] = useState({});
  const { enqueueSnackbar } = useSnackbar();
  const [dropDownValue, setDropDownValue] = useState("");
  const { user } = useAuthStateContext();
  useEffect(() => {
    async function fetchData() {
      const response = await axios({
        baseURL: process.env.REACT_APP_API_DNS,
        url: "/table-fields",
        method: "get",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${user.token}`,
        },
      });
      if (response.status !== 200) {
        enqueueSnackbar("Getting table with fields failed. Please refresh page to try again", {
          variant: "error",
        });
      }
      setTableWithFields(response.data);
    }
    fetchData();
  }, []);

  return (
    <Container style={{ display: "flex", flexDirection: "column" }}>
      <h2 style={{ marginBottom: "0rem" }}>Insert data dynamically</h2>
      <Dropdown
        value={dropDownValue}
        setValue={setDropDownValue}
        name={"Table Options"}
        options={Object.keys(tableWithFields).map((table) => {
          return {
            value: table,
            label: table,
          };
        })}
      />

      {dropDownValue && (
        <div style={{ margin: "auto", width: "60%" }}>
          <FieldInsert data={tableWithFields[dropDownValue]} table={dropDownValue} />
        </div>
      )}
    </Container>
  );
};

export default InsertionPage;
