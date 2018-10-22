#region One Identity - Open Source License
//
// One Identity - Open Source License
//
// Copyright 2018 One Identity LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software. Any and all copies of the above
// copyright and this permission notice contained in the Software shall not be
// removed, obscured, or modified.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
#endregion


using System.Data;
using System.Drawing;

using VI.Base;


namespace VI.Tools.ReplicationInfo
{
	/// <summary>
	/// Summary description for Job.
	/// </summary>
	public class ObjectServer : ObjectBase
	{

		public override string[] Columns
		{
			get
			{
				return new string[] {  "displaytext",
					"chgnr",
					"isready",
					"changed",
					"uid_applicationserver",
					"uid_parentapplicationserver"
				};

			}
		}

		public ObjectServer()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		public ObjectServer( IDataReader rData )
		{
			DbVal dbVal;
			string strColumn;

			for (int iCol = 0; iCol < rData.FieldCount; iCol++)
			{
				// get the data
				dbVal = new DbVal( rData.GetValue(iCol) );

				strColumn = rData.GetName(iCol).ToLowerInvariant();

				// add to data hash
				_data.Add( strColumn, dbVal );
			}
		}

		public Color StateColor
		{
			get
			{
				string state = GetData( "WasError" );

				if (state == "1")
					return Color.Red;
				else
					return Color.Black;

			}
		}


	}
}