--
-- Copyright (C) 2016 Red Hat, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
INSERT INTO CUSTOMER (ID,SSN,NAME) VALUES (20, 'CST01005','db2 Alan de Young');
INSERT INTO CUSTOMER (ID,SSN,NAME) VALUES (21, 'CST01006','db2 Andria Tarocchi');
INSERT INTO CUSTOMER (ID,SSN,NAME) VALUES (22, 'CST01007','db2 Ahmed Ali');

INSERT INTO ADDRESS (ID, STREET, ZIP, CUSTOMER_ID) VALUES (20, 'DB2 Address', '12345', 20);

commit;

