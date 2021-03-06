local n = "DCC01E002560134524D9110539E640F91312F3F5CDCBB86CB410243967045F3FA05FB73C4E7FADBBECC7ED9065D5C905612E473D566022721E144BC250B53A2BD656C066E8F44568448B402356CC1CE9FA125ECF799712AF5C67D036EC88712C73715B26BB9D8BF3E44FC5DE2B8102F5C6D345B7F2006CA039AB5B05DD098887";
local d = "797C5546594B556F9106D0C2228A2029B32094182B68B91741C53C5A46E27614CB0AC209B35DBADC184432EE6BCCCAB3663714C7A1D8883C6B675A06176A9516F2E13123848880C04BC7B24B00ACACD8B0CB3C6E87AD14482A043DE457DF7206FC689CFD301AF7E06230C6E498A3458717FD29EFC02791E80352E67C4E9B23B9";
local e = "010001";
local p = "FC488AD62B4598A702F8A5B74F53A9A30F3793F05BDA1666913CF2D852C6E18AC525FBB943BD603AF794CAEC0EDB93F418BF689045044947E0CDC28CF0580ADB";
local q = "E000A6F135FA373C83B7D2F74C1DD9579D3D586080C72BD87D0F2B5B6C23AEE33DB5DA478CF4902D2C7618335DC196FE58EFBA9FD23D51523852854AD827EAC5";
local dp = "ECB166C8DF1A51C947A95F58E7AD17B7EB7BFA6984D3CD3677C756140D3D98B7E895E5610123F8D7FA16F87796CCFE3802CBFA5F78D137AB9F478CE34C4F5E07";
local dq = "6151C735FAE687C301D306942C7CB765AA49F1B093A274B92CB43F790BC58100F7599FC900436CB443A1D727D1EEFEA3E88DD6BE030062E95ED0F35A2E0941A5";
local invq = "E68DBBB2F2EB5C96A68ADF53CA9453D0354DDA21CCD15D3F1E43975058719292F3C7EDBCAB95BEB2DD643BCA92D388DEA5BE484DE0019C2332BCC53EB744B214";

local data = "11223344";
local ret = "";

ret = rsa_calc_e(p, dp);

if(ret ~= e)
then
	error("rsa_calc_e fail");
	print(ret);
else
	print("rsa_calc_e pass");
end

ret = rsa_calc_e(q, dq);

if(ret ~= e)
then
	error("rsa_calc_e fail");
	print(ret);
else
	print("rsa_calc_e pass");
end

ret = rsa_encrypt(data, n, e);

if(ret ~= "DC36281F22FC701DEA4A306CDDE3D9F510223D42FF3BC03BF8952F84400267D116C03D46C661E59F70473319281E251E8F07E4FB4A4A3F9235BE17FE6D3D6FA97CF51CEDAB4D2A3EB61E8CA1A2ED7BA7E8FA49DA1765A79B24A11BE1CB80F15946BEEBB43B1DDDCB948701EC8151155AD7358E146ADCB5E035BE978ACE7BCF10")
then
	error("rsa_encrypt fail");
	print(ret);
else
	print("rsa_encrypt pass");
end

data = "DC36281F22FC701DEA4A306CDDE3D9F510223D42FF3BC03BF8952F84400267D116C03D46C661E59F70473319281E251E8F07E4FB4A4A3F9235BE17FE6D3D6FA97CF51CEDAB4D2A3EB61E8CA1A2ED7BA7E8FA49DA1765A79B24A11BE1CB80F15946BEEBB43B1DDDCB948701EC8151155AD7358E146ADCB5E035BE978ACE7BCF10";

ret = rsa_decrypt(data, n, d);

if(ret ~= "11223344")
then
	error("rsa_decrypt fail");
	print(ret);
else
	print("rsa_decrypt pass");
end

ret = rsa_crt_decrypt(data, p, q, dp, dq, invq);

if(ret ~= "11223344")
then
	error("rsa_crt_decrypt fail");
	print(ret);
else
	print("rsa_crt_decrypt pass");
end

data = "1234567890";

ret = pkcs_1(data, n, d);

if(ret ~= "1EE2B2A01AA5878F21D216EC68C4DC613B24EE4539202FC6FBB238872B2FCD1A22832271EF3611BA1B178C73C0605BC17B21CAEA013CB92060BDA6A18E66FF844576E6AD5E326B921204A3BF0EF6B8DD20997F276B2F08AD053F6E81CEA767B3865558B270A356B67358C008D0B0AB6F39537DB70B32F1D76B24E96DA94DF7E7")
then
	error("pkcs_1 fail");
	print(ret);
else
	print("pkcs_1 pass");
end

local rsa_key = {};

rsa_key = rsa_generate_key(1024, e);

if(rsa_key == nil)
then
	error("rsa_generate_key fail");
else
	n = rsa_key[0];
	d = rsa_key[1];
	p = rsa_key[2];
	q = rsa_key[3];
	dp = rsa_key[4];
	dq = rsa_key[5];
	invq = rsa_key[6];
	
	local ret_rsa_en;
	local ret_rsa_de;
	local ret_rsa_crt;
	
	data = "011478C6277DC199C404B48300099E61DEDDC7A7D63EA01D3A65FD57ED44B015FA2A1B1A215AE1CC8CC31394E3C0DE5172073800A4F84D84C4B6B6CDA728D5F29BE472A2D0EAAFF1E0E467FA927803061A3108B31DD1A1C12B745B1CD94761D8D4F537D097BA62D6769B088361A2EEF18206042562D56FBD31DB3254DD611321";
	
	ret_rsa_en = rsa_encrypt(data, n, e);
	
	ret_rsa_de = rsa_decrypt(ret_rsa_en, n, d);
	
	ret_rsa_crt = rsa_crt_decrypt(ret_rsa_en, p, q, dp, dq, invq);
	
	if(ret_rsa_de == ret_rsa_crt and ret_rsa_crt == data)
	then
		print("rsa_generate_key pass");
	else
		error("rsa_generate_key fail");
		print(ret_rsa_en);
		print(ret_rsa_de);
		print(ret_rsa_crt);
	end
end


