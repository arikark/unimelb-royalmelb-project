import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";

const useStyles = makeStyles((theme) => ({
  formControl: {
    minWidth: 120,
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function Dropdown({ options, value, setValue, name }) {
  const classes = useStyles();

  const handleChange = (event) => {
    setValue(event.target.value);
  };

  return (
    <FormControl required className={classes.formControl}>
      <h3 style={{ marginBottom: "0.5rem" }}>{name.charAt(0).toUpperCase() + name.slice(1)}</h3>
      <Select
        native
        value={value}
        onChange={handleChange}
        name={name}
        inputProps={{
          id: `${name}-dropdown`,
        }}
        style={{ width: "20rem" }}
      >
        <option value="None">None</option>
        {options.map((option) => (
          <option value={option.value}>{option.label}</option>
        ))}
      </Select>
    </FormControl>
  );
}
