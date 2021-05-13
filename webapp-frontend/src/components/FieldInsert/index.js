import React, { useCallback, useEffect, useState } from "react";
import TextField from "@material-ui/core/TextField";
import { Button } from "@material-ui/core";
import { useSnackbar } from "notistack";
import axios from "axios";
import { useAuthStateContext } from "../../context/authProvider";

const FieldInsert = ({ table, data }) => {
  const { enqueueSnackbar } = useSnackbar();
  const { user } = useAuthStateContext();

  const [fieldsWithValues, setFieldsWithValues] = useState({});
  const onSubmit = useCallback(async () => {
    async function insertData() {
      const fields = Object.keys(fieldsWithValues);
      try {
        const reqBody = {
          baseURL: process.env.REACT_APP_API_DNS,
          url: "/fields",
          method: "post",
          headers: {
            "content-type": "application/json",
            Authorization: `Bearer ${user.token}`,
          },
          data: {
            table,
            fields,
            values: fields.map((field) => fieldsWithValues[field]),
          },
        };
        await axios(reqBody);
        enqueueSnackbar("Successfully added row", {
          variant: "success",
        });
      } catch (e) {
        enqueueSnackbar(e.response?.data?.message, {
          variant: "error",
        });
      }
    }
    insertData();
  }, [fieldsWithValues, table, enqueueSnackbar]);

  useEffect(() => {
    setFieldsWithValues({});
  }, [table]);

  return (
    <>
      <h2>Fields To Insert</h2>
      {data.map((item) => (
        <TextField
          key={item.field}
          label={item.field}
          style={{ margin: 8 }}
          placeholder="Placeholder"
          helperText={`Field Data type: ${item.type}`}
          fullWidth
          margin="normal"
          InputLabelProps={{
            shrink: true,
          }}
          variant="outlined"
          onChange={(event) =>
            setFieldsWithValues({
              ...fieldsWithValues,
              [item.field]: event.target.value,
            })
          }
        />
      ))}
      <Button variant="contained" color="primary" fullWidth onClick={onSubmit}>
        Submit
      </Button>
    </>
  );
};

export default FieldInsert;
