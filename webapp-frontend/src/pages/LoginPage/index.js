import React, { useState, useCallback } from "react";

import Button from "@material-ui/core/Button";
import Typography from "@material-ui/core/Typography";
import Container from "@material-ui/core/Container";

import useStyles from "./styles";
import { TextField } from "@material-ui/core";
import { useSnackbar } from "notistack";
import { useAuthActionContext, useAuthStateContext } from "../../context/authProvider";
import Loading from "../../components/Loading";

const LoginPage = () => {
  const classes = useStyles();
  const { enqueueSnackbar } = useSnackbar();

  const [user, setUser] = useState({});
  const { login } = useAuthActionContext();
  const { loading: loginLoading } = useAuthStateContext();
  const onSubmit = async () => {
    if (!user.password || !user.username) {
      return enqueueSnackbar("Username or Password missing", {
        variant: "error",
      });
    }
    await login(user.username, user.password);
  };

  return (
    <Container maxWidth="xs" className={classes.container}>
      <Typography variant="h6" className={classes.title}>
        Audit Ingester
      </Typography>

      <TextField
        id="username-textfield"
        label="Username"
        InputLabelProps={{
          shrink: true,
        }}
        variant="outlined"
        style={{ marginTop: "1rem", width: "13rem" }}
        onChange={(event) => {
          const val = event.target.value;
          setUser((prevUser) => {
            return { ...prevUser, username: val };
          });
        }}
      />
      <TextField
        id="password-textfield"
        label="Password"
        InputLabelProps={{
          shrink: true,
        }}
        variant="outlined"
        style={{ marginTop: "1rem", width: "13rem" }}
        type="password"
        onChange={(event) => {
          const val = event.target.value;
          setUser((prevUser) => {
            return { ...prevUser, password: val };
          });
        }}
      />
      <Button
        onClick={onSubmit}
        disabled={false}
        variant="contained"
        style={{ width: "12rem", marginTop: "1rem" }}
        color="primary"
      >
        Sign in
      </Button>
      {loginLoading && <Loading />}
    </Container>
  );
};

export default LoginPage;
