import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";
import CSVReader from "react-csv-reader";
import "./styles.css";
import CSVTable from "../../components/CSVTable";
import { v4 as uuidv4 } from "uuid";
import _ from "lodash";
import { Button, Icon, Container } from "@material-ui/core";
import Dropdown from "../../components/Dropdown";
import Papa from "papaparse";
import FileCycler from "../../components/FileCycler";
import { useUploadFiles } from "../../hooks/UploadProgress";
import Loading from "../../components/Loading";
import { useSnackbar } from "notistack";
import JSONPretty from "react-json-pretty";
import "react-json-pretty/themes/monikai.css";

const papaparseOptions = {
  header: true,
  dynamicTyping: true,
  skipEmptyLines: true,
  transformHeader: (header) => header.toLowerCase().replace(/\W/g, "_"),
};

const CSVPage = () => {
  const { enqueueSnackbar } = useSnackbar();
  const [csvsState, setCsvsState] = useState([]);
  const [csvIndx, setCsvIndx] = React.useState(1);
  const [uploadFiles, loading, error] = useUploadFiles();
  const handleAttachFile = (e) => {
    try {
      const files = e.target.files;
      let newState = [...csvsState];
      for (let i = 0; i < files.length; i++) {
        const id = uuidv4();
        newState = [
          ...newState,
          {
            id,
            file: files[i],
            progress: 0,
          },
        ];
      }
      setCsvsState(newState);
    } catch (e) {
      console.log(e);
    }
    e.target.value = ""; // to clear the current file
  };

  const handleChange = async (event, value) => {
    setCsvIndx(value);
  };

  const handleSubmission = async () => {
    try {
      await uploadFiles(csvsState);
      enqueueSnackbar("Upload of files succeeded!", {
        variant: "success",
      });
    } catch (e) {
      enqueueSnackbar(e.response?.data?.message || "Upload failed, please try again", {
        variant: "error",
      });
    }
  };

  useEffect(() => {
    if (csvsState.length > 0 && !(csvsState[csvIndx - 1]?.csv || csvsState[csvIndx - 1]?.json)) {
      if (csvsState[csvIndx - 1].file?.type === "application/json") {
        csvsState[csvIndx - 1].file.text().then((res) => {
          const jsonifiedRes = JSON.parse(res);
          const newCsvState = [...csvsState];
          newCsvState[csvIndx - 1] = {
            ...csvsState[csvIndx - 1],
            json: jsonifiedRes,
          };
          setCsvsState(newCsvState);
        });
      } else {
        Papa.parse(csvsState[csvIndx - 1].file, {
          ...papaparseOptions,
          complete: function (results, file) {
            const newCsvState = [...csvsState];
            newCsvState[csvIndx - 1] = {
              ...csvsState[csvIndx - 1],
              csv: results.data,
            };
            setCsvsState(newCsvState);
          },
        });
      }
    }
  }, [csvIndx, setCsvsState, csvsState, setCsvIndx]);

  return (
    <Container style={{ display: "flex", flexDirection: "column" }}>
      <span
        style={{
          display: "flex",
          flexDirection: "row",
          justifyContent: "space-evenly",
          marginTop: "0.5rem",
        }}
      >
        <Button variant="contained" component="label" style={{ width: "20rem" }}>
          Upload Files
          <input
            type="file"
            onChange={handleAttachFile}
            multiple
            style={{ display: "none" }}
            accept=".csv, .json"
          />
        </Button>
        <Button
          variant="contained"
          color="secondary"
          style={{ width: "20rem" }}
          onClick={() => {
            setCsvsState([]);
            setCsvIndx(1);
          }}
        >
          Clear Files
        </Button>
      </span>
      {csvsState.length > 0 ? (
        <FileCycler handleChange={handleChange} csvs={csvsState} csvIndx={csvIndx} />
      ) : (
        <h4 style={{ textAlign: "center" }}>No files currently added</h4>
      )}
      {csvsState[csvIndx - 1]?.csv ? (
        <CSVTable csv={csvsState[csvIndx - 1]?.csv || []} />
      ) : csvsState[csvIndx - 1]?.json ? (
        <Container
          style={{
            overflow: "scroll",
            height: "60vh",
            display: "block",
          }}
        >
          <JSONPretty id="json-pretty" data={csvsState[csvIndx - 1]?.json} />
        </Container>
      ) : (
        <CSVTable csv={csvsState[csvIndx - 1]?.csv || []} />
      )}
      <Button
        variant="contained"
        color="primary"
        style={{ marginTop: "1rem" }}
        endIcon={<Icon>send</Icon>}
        onClick={handleSubmission}
        disabled={!csvsState.length}
      >
        Send
      </Button>
      {loading && !error && <Loading />}
    </Container>
  );
};

export default CSVPage;
