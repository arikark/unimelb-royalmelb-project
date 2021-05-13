import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Pagination from "@material-ui/lab/Pagination";
import PaginationItem from "@material-ui/lab/PaginationItem";

const useStyles = makeStyles((theme) => ({
  root: {
    "& > *": {
      marginTop: theme.spacing(2),
    },
  },
}));

const FileCycler = ({ csvs, handleChange, csvIndx }) => {
  const classes = useStyles();

  return (
    <div className={classes.root} style={{ paddingBottom: "1rem", margin: "auto" }}>
      <Pagination
        page={csvIndx}
        count={Object.values(csvs).length}
        renderItem={(item) => {
          return (
            <PaginationItem
              {...item}
              page={csvs[item.page - 1]?.file?.name}
              onChange={handleChange}
            />
          );
        }}
        onChange={handleChange}
        variant="outlined"
        color="primary"
      />
    </div>
  );
};

export default FileCycler;
