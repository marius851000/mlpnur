{ buildEnv, lib, callPackage, beta ? false }:# files to download are stored at https://www.mylittlekaraoke.com/store/webinst/linux.webinst
# under the form url\nsize\nrepeat
let
	fetchmlk = callPackage ./fetchmlk.nix { };

	# buildEnv make so the first have priority under the second. The order of data is the inverse (last one should be the most recent. The order is reversed later)
	datas = [
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base1.tar.mlk" "ViKgpQqG06X2T5sKUZAUdn7kunpvzZ3t8Jr7/zLsvTY="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base2.tar.mlk" "3Wx5r3oanp2GtqMdLFsQQTC2dC6ITFTcWW8kIn/W1FI="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base3.tar.mlk" "fkN2mO7MVcPk38ZTRlkMtvC7/wy40rlrpFKwBTFukJ4="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base4.tar.mlk" "emEQ1GOJHi62pWkLmzJ+LmmQ3YcXJGsqarqaM0EGafI="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base5.tar.mlk" "MOsPDx/RaMwGl/Vl+8OtUFz7+tReI/U6cuVePlb8pDs="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base6.tar.mlk" "lFBcM1jOf9TpOaeIu+VQlh4m0jqoB/8S2tLd6Pp+xMc="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base7.tar.mlk" "4/nhebktEqz6job16zWo1TelkgqJbs7KPQ1If84eFTw="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base8.tar.mlk" "yVKSrvhZIhzU7ezWJ1YC+xVtD1TN6sDlclK/80W9ErA="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base9.tar.mlk" "3PlV9wYM3UiKpAjO/Xm3JkVOpZLIQwfmv0m7yMwf9Ic="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base10.tar.mlk" "UuOQm7BQ1NLtxLhPqZ32xh6tlm/ZBQYBqpedJk/iHsU="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base11.tar.mlk" "2aA0qTT/f7/siXJtewZrCbQ2yOoTxM+JMYnPaxP9Wvw="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base12.tar.mlk" "U8/803l2lHR2/oCI7KXz6nltZjGWxjECLUsE0HCH/bc="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base13.tar.mlk" "SseCXfbmnlYL/hpiqI19E6yxcMClOyaUA9uhegmF5T4="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base14.tar.mlk" "oHYNZWEV5+Fv/oYOjaJrP34mJFKISge+b+V7kPdpXnY="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base15.tar.mlk" "grZjDXCVeewhG0UFkinMyx6xtNHN6a0TUfb1anw/8PQ="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base16.tar.mlk" "cAAhaPQ+L1G7zCsfloF2RHYLoM01H8X3TqDeZ2+zQyM="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base17.tar.mlk" "xLAcDRkT1PE0n6INy5E52mfV+yot4ASZ3lBVa8oQzLE="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base18.tar.mlk" "+e/g2SlJsSQOZ7Oak9CJIGZ4MYGIxWI9yNlS+vZae6E="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base19.tar.mlk" "RR49MVDtodLeELHDEDZB6wDN/5M/fwsIXsB++3zvKRc="]
		["https://www.mylittlekaraoke.com/store/webinst/AC3-base20.tar.mlk" "B7VqEb0H40bhQc5UwfjIwXEmP2jls0XIK9Jpz+TIXQc="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base21.tar.mlk" "KxEiejhbpJ/AcRWDSIjik941Z1fBZyV5Wgud3k5/GuU="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base22.tar.mlk" "nmzxU35Gsc3WUuLW4HmT3rVwCSP8AyJzoXIYKrLCJZc="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base23.tar.mlk" "/vaRLYrtoBJdbnBBamlBlD0JSv3Tj8fGmLNIDtiyg4s="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base24.tar.mlk" "mzhJAGD/93isGFLfhrhmFnsoH/2jspVVcpISA9EG7O0="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base25.tar.mlk" "0Sfd+SrPdoY+SA9NUD2xQYnI484fkM0fF/vgX4IitFY="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base26.tar.mlk" "P5PbMtKH50/naloUJaFRoJRrbkUVZ651dd5G9/qXvTE="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base27.tar.mlk" "ZZGis9GxxkWgfvbuaNLjJGsZBjVkv4UfgCfMj+4dE7Q="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base28.tar.mlk" "5WPsHxC6/HPAUCIWIZ+BHkQjLT2Qel5i6QRoSvGR2uc="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base29.tar.mlk" "1+shLea+xIkLs9zqm83Iqa0YoPXI/ZAzmKnP664TM/I="]
		#twice ?
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base30.tar.mlk" "VtJtFb/fN030B1s2VpF/3f84wdgjTOSbMlW8i3ilWAE="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base31.tar.mlk" "VtJtFb/fN030B1s2VpF/3f84wdgjTOSbMlW8i3ilWAE="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base32.tar.mlk" "NrDwkc0MDXE4aT6MPK5z3Kxwjw6R4WNx+3upGXw8WdI="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base33.tar.mlk" "iUjsPvbYVD0xgKuyCJ1SaHZjyGtjEp8fkCvNojWUBS8="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM4-base34_1.tar.mlk" "Z7ViRIXtrz1fS+YMtNz22p1nkiujF3CPlkU7Rw0PtdM="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base35.tar.mlk" "5RNnZevb1tPnKUoTiDwmLn+bg+ththbckRo+NyK3j3g="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base36.tar.mlk" "RtJwpsnlbQlDL23hQKVTg8UKAKjzYnXD8VO++7M+R14="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base37.tar.mlk" "gKo4EFhwU9j3ksio7qPkh3u23nwwZBbFNGW4rjXSCO8="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base38.tar.mlk" "VHIi5UFxV5ED0PN97vMUg4CiUzORtQD9+MWsznSDMck="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base39.tar.mlk" "Cq/7yClQ3kW0fAEQVfL4MqCG0ATfCl0kbx4qzyGE2Ek="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base40.tar.mlk" "unejM6wJqH1C3JLOW21FEcYgKrOJj9P7UZnigvnjuMo="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base41.tar.mlk" "wUlQ10nd4zmXTJFq7GiBxg5RH2NucbCBBA+7FOGtD7E="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base42.tar.mlk" "8d5O7vEzJ0NBRw0oym5Kz3o6zhY3OJ+Fp5ku8daAtik="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base43.tar.mlk" "5BIo+LxJBnYCivPJ0t/ek7f9X+rmSopOEXivDxghc8g="]
		["https://www.mylittlekaraoke.com/store/webinst/SIM5-base44.tar.mlk" "9XFEkCfbt/i5fDn7dYJ4LdrygMdOa2upZCYlswVT15I="]
		["https://www.mylittlekaraoke.com/store/webinst/theme2.mlt" "BVc48hSbrhxvMBpBcJlJmpaVwEdX8wYXzvU78G5+F3g="]
		["https://www.mylittlekaraoke.com/store/webinst/avatars1.mlu" "61ujJU5XYHAhFJL1hEmGPlbkMh1G/QD7F/SD8ZxwUY8="]
	];

	datas_downloaded = map (entry: fetchmlk { url = builtins.head entry; sha256 = builtins.elemAt entry 1; }) datas;

	beta_downloaded = map (x: fetchmlk {
			url = builtins.elemAt x 0;
			name = builtins.elemAt x 1;
			sha256 = builtins.elemAt x 2;
		})
		(lib.importJSON ./beta.json);

in buildEnv {
	name = "my-little-karaoke-data";
	paths = lib.reverseList (datas_downloaded ++ (if beta then beta_downloaded else []));
	ignoreCollisions = true;
}
