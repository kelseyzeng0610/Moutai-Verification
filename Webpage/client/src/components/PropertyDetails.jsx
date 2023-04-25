import React, { useState, useContext } from "react";
import { TransactionContext } from "../context/TransactionContext";

const PropertyDetails = () => {
  const { getPropertyDetails } = useContext(TransactionContext);
  const [searchID, setSearchID] = useState("");
  const [propertyDetails, setPropertyDetails] = useState(null);

  const handleSearch = async () => {
    if (searchID) {
      const details = await getPropertyDetails(searchID);
      console.log(details);
      setPropertyDetails(details);
    }
  };

  return (
    <div className="flex flex-col items-center justify-start w-full p-5 mt-10 blue-glassmorphism">
      <input
        placeholder="Search Bottle ID"
        type="number"
        value={searchID}
        onChange={(e) => setSearchID(e.target.value)}
        className="my-2 w-full rounded-sm p-2 outline-none bg-transparent text-white border-none text-sm white-glassmorphism"
      />
      <button
        type="button"
        onClick={handleSearch}
        className="text-white w-full mt-2 border-[1px] p-2 border-[#3d4f7c] hover:bg-[#3d4f7c] rounded-full cursor-pointer"
      >
        Search
      </button>
      {/* {propertyDetails && (
        <div className="w-full mt-6 p-4 bg-white rounded-lg shadow-md">
          <h2 className="text-lg font-bold mb-3">Property Details:</h2>
          <ul>
            {Object.entries(propertyDetails).map(([key, value]) => (
              <li key={key} className="mb-2">
                <span className="font-semibold">{key}:</span> {value}
              </li>
            ))}
          </ul>
        </div>
      )} */}
    </div>
  );
};

export default PropertyDetails;
