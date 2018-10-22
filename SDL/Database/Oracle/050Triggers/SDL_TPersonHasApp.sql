--
-- One Identity - Open Source License
--
-- Copyright 2018 One Identity LLC
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software. Any and all copies of the above
-- copyright and this permission notice contained in the Software shall not be
-- removed, obscured, or modified.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tabelle PersonHasApp
-- Event: Insert
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



Create Or Replace Trigger SDL_TIPersonHasApp For Insert On PersonHasApp
	COMPOUND TRIGGER


--------------------------------------------------------------------------------
-- Declarations
--------------------------------------------------------------------------------

	v_GenProcID 	 QBM_GTypeDefinition.YGuid := QBM_GCommon2.FClientContextGetGenProcID();
	
	v_ConfigADS varchar2(100) := QBM_GGetInfo2.FGIConfigParmValue('TargetSystem\ADS');
	v_ConfigLDP varchar2(100) := QBM_GGetInfo2.FGIConfigParmValue('TargetSystem\LDAP');
	
	v_UID_Person_tab QBM_GTypeDefinition.YGuidtab := QBM_GTypeDefinition.YGuidtab();

	v_DBQueueElements QBM_GTypeDefinition.YDBQueueRaw := QBM_GTypeDefinition.YDBQueueRaw();

	v_exists 		 QBM_GTypeDefinition.YBool;
	v_errmsg		  varchar2(400);



--------------------------------------------------------------------------------
-- After each row
--------------------------------------------------------------------------------
After each row is
begin


	if :new.XIsInEffect = 1 then
		v_UID_Person_tab.extend(1);
		v_UID_Person_tab(v_UID_Person_tab.last) := :new.UID_Person;
	End If;


end after each row;



--------------------------------------------------------------------------------
-- After Statement
--------------------------------------------------------------------------------
After Statement is
begin


		If '1' = v_ConfigADS Then
		
			select x.UID_object, null, v_GenProcID
					bulk collect into v_DBQueueElements
			  From	   (Select Distinct a.uid_ADSAccount As uid_object
						  From ADSAccount a join table(v_UID_Person_tab) vuid on a.uid_person = vuid.column_value
						  where a.isappaccount = 1
						  ) x;

			QBM_GDBQueue.PDBQueueInsert_Bulk('SDL-K-ADSAccountInADSGroup', v_DBQueueElements);
		
		End If;


		If '1' = v_ConfigLDP Then
		
			select x.UID_object, null, v_GenProcID
					bulk collect into v_DBQueueElements
			  From	   (Select Distinct a.uid_LDAPAccount As uid_object
						  From LDAPAccount a join table(v_UID_Person_tab) vuid on a.uid_person = vuid.column_value
						  where a.isappaccount = 1
						  ) x;

			QBM_GDBQueue.PDBQueueInsert_Bulk('SDL-K-LDAPAccountInLDAPGroup', v_DBQueueElements);
		
		End If;

Exception
	When Others Then
		raise_application_error(-20100, 'DatabaseException', True);
end After statement;




end SDL_TIPersonHasApp;
go


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- / Tabelle PersonHasApp
-- / Event: Insert
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------






--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tabelle PersonHasApp
-- Event: Update
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------




Create Or Replace Trigger SDL_TUPersonHasApp For Update On PersonHasApp
	COMPOUND TRIGGER


--------------------------------------------------------------------------------
-- Declarations
--------------------------------------------------------------------------------

	v_GenProcID 	 QBM_GTypeDefinition.YGuid := QBM_GCommon2.FClientContextGetGenProcID();
	
	v_ConfigADS varchar2(100) := QBM_GGetInfo2.FGIConfigParmValue('TargetSystem\ADS');
	v_ConfigLDP varchar2(100) := QBM_GGetInfo2.FGIConfigParmValue('TargetSystem\LDAP');
	
	v_UID_Person_tab QBM_GTypeDefinition.YGuidtab := QBM_GTypeDefinition.YGuidtab();

	v_DBQueueElements QBM_GTypeDefinition.YDBQueueRaw := QBM_GTypeDefinition.YDBQueueRaw();

	v_exists 		 QBM_GTypeDefinition.YBool;
	v_errmsg		  varchar2(400);



--------------------------------------------------------------------------------
-- After each row
--------------------------------------------------------------------------------
After each row is
begin


	if (UPDATING('XIsInEffect') or UPDATING('XOrigin'))and QBM_GGetInfo2.FGIXOriginChanged_Effect(:old.XOrigin, :new.XOrigin, :old.XIsInEffect, :new.XIsInEffect) = 1 then
		v_UID_Person_tab.extend(1);
		v_UID_Person_tab(v_UID_Person_tab.last) := :new.UID_Person;
	End If;


end after each row;



--------------------------------------------------------------------------------
-- After Statement
--------------------------------------------------------------------------------
After Statement is
begin


		If '1' = v_ConfigADS Then
		
			select x.UID_object, null, v_GenProcID
					bulk collect into v_DBQueueElements
			  From	   (Select Distinct a.uid_ADSAccount As uid_object
						  From ADSAccount a join table(v_UID_Person_tab) vuid on a.uid_person = vuid.column_value
						  where a.isappaccount = 1
						  ) x;

			QBM_GDBQueue.PDBQueueInsert_Bulk('SDL-K-ADSAccountInADSGroup', v_DBQueueElements);
		
		End If;


		If '1' = v_ConfigLDP Then
		
			select x.UID_object, null, v_GenProcID
					bulk collect into v_DBQueueElements
			  From	   (Select Distinct a.uid_LDAPAccount As uid_object
						  From LDAPAccount a join table(v_UID_Person_tab) vuid on a.uid_person = vuid.column_value
						  where a.isappaccount = 1
						  ) x;

			QBM_GDBQueue.PDBQueueInsert_Bulk('SDL-K-LDAPAccountInLDAPGroup', v_DBQueueElements);
		
		End If;

Exception
	When Others Then
		raise_application_error(-20100, 'DatabaseException', True);
end After statement;




end SDL_TUPersonHasApp;
go




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- / Tabelle PersonHasApp
-- / Event: Update
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
