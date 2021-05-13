import React from "react";
import "./App.css";

import { SnackbarProvider } from "notistack";

import { AuthenticationProvider } from "./context/authProvider";
import Main from "./Main";

const styles = {
  success: { backgroundColor: "purple" },
  error: { backgroundColor: "blue" },
  warning: { backgroundColor: "green" },
  info: { backgroundColor: "yellow" },
};

function App() {
  return (
    <SnackbarProvider
      classes={{
        variantSuccess: styles.success.backgroundColor,
        variantError: styles.error.backgroundColor,
        variantWarning: styles.warning.backgroundColor,
        variantInfo: styles.info.backgroundColor,
      }}
      maxSnack={3}
    >
      <AuthenticationProvider>
        <Main />
      </AuthenticationProvider>
    </SnackbarProvider>
  );
}

export default App;
