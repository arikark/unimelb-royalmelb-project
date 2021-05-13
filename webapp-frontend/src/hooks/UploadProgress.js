import { useCallback, useState } from "react";
import axios from "axios";
import { useAuthStateContext } from "../context/authProvider";

export const useUploadFiles = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);
  const { user } = useAuthStateContext();
  const uploadFiles = async (files) => {
    if (files.length) {
      const formPayload = new FormData();
      files.forEach((file) => {
        formPayload.append(file.file.name, file.file);
      });
      setLoading(true);
      try {
        const res = await axios({
          baseURL: process.env.REACT_APP_API_DNS,
          url: "/csv",
          method: "post",
          headers: {
            "content-type": "application/json",
            Authorization: `Bearer ${user.token}`,
          },
          data: formPayload,
        });
        setLoading(false);
        if (res.status >= 400) {
          setError(true);
          throw Error(res.statusText);
        }
        return { data: res.data, status: res.status };
      } catch (e) {
        setError(true);
        throw e;
      }
    }
  };
  return [uploadFiles, loading, error];
};
