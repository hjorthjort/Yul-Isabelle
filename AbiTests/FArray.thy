theory FArray imports "../AbiTypes" "../Hex" "../AbiTypesSyntax" "../AbiDecode" "../AbiEncode"

begin

(* solidity *)

(*
 contract C {
    function getEncoding() external returns (bytes memory) {
        uint256[4] memory x = [uint256(42), uint256(43), uint256(44), uint256(45)];
        return abi.encode(x);
    }
}
*)

(* hex output *)

(*

0x000000000000000000000000000000000000000000000000000000000000002a000000000000000000000000000000000000000000000000000000000000002b000000000000000000000000000000000000000000000000000000000000002c000000000000000000000000000000000000000000000000000000000000002d

*)

definition test_in :: "8 word list" where
"test_in = hex_splits 
''000000000000000000000000000000000000000000000000000000000000002a000000000000000000000000000000000000000000000000000000000000002b000000000000000000000000000000000000000000000000000000000000002c000000000000000000000000000000000000000000000000000000000000002d''"

definition test_schema :: abi_type where
"test_schema = ABI_TYPE\<guillemotleft>uint256 [4]\<guillemotright>"

definition test_out :: "abi_value" where
"test_out = Vfarray (Tuint 256) 4 (map (Vuint 256) [42, 43, 44, 45])"

value "decode test_schema test_in"

value "decode test_schema test_in = Ok test_out"

value "encode test_out = Ok test_in"

end