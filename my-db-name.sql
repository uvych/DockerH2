CREATE ALIAS IF NOT EXISTS MRPC9000 AS $$ 
String mrpc9000(String inv , String out) throws Exception {
out = inv;
return out;}$$
