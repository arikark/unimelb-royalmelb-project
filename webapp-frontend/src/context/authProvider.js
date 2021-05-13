import axios from "axios";
import { useSnackbar } from "notistack";
import React, { useState } from "react";

const AuthenticationProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  const { enqueueSnackbar } = useSnackbar();

  const login = async (username, password) => {
    const reqBody = {
      baseURL: process.env.REACT_APP_API_DNS,
      url: "/login",
      method: "post",
      data: {
        username,
        password,
      },
    };
    setLoading(true);
    try {
      const res = await axios(reqBody);
      console.log(res);
      setUser({
        details: res.data?.user,
        token: res.data?.token,
      });
    } catch (e) {
      console.log(e.response);
      enqueueSnackbar(e.response?.data?.message || "Error in logging in", {
        variant: "error",
      });
    }
    setLoading(false);
  };

  return (
    <AuthenticationStateContext.Provider
      value={{
        loading,
        user,
      }}
    >
      <AuthenticationActionContext.Provider
        value={{
          login,
        }}
      >
        {children}
      </AuthenticationActionContext.Provider>
    </AuthenticationStateContext.Provider>
  );
};

/**
 * Provides the user's authentication state if they are logged in.
 */
const AuthenticationStateContext = React.createContext({
  loading: true,
  user: null,
});

const AuthenticationActionContext = React.createContext({
  login: (username, password) => {},
});

function useAuthStateContext() {
  const context = React.useContext(AuthenticationStateContext);
  if (context === undefined) {
    throw new Error("useAuthAction must be used within the Authentication Provider");
  }
  return context;
}

function useAuthActionContext() {
  const context = React.useContext(AuthenticationActionContext);
  if (context === undefined) {
    throw new Error("useAuthAction must be used within the Authentication Provider");
  }
  return context;
}

export { useAuthStateContext, useAuthActionContext, AuthenticationProvider };
