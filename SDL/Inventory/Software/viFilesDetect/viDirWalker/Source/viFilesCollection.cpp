// viFilesCollection.cpp: implementation of the CviFilesCollection class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "viFilesCollection.h"


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
CviFilesCollection::CviFilesCollection()
{
	m_pFileInfoCollection = new CCollection<CviFileInfo>(FC_INITIAL_SIZE, FC_HASH_SIZE);
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
CviFilesCollection::~CviFilesCollection()
{
	if ( m_pFileInfoCollection ) delete( m_pFileInfoCollection );
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
bool CviFilesCollection::Add( CviFileInfo * pItem, ULONG pos )
{
	return m_pFileInfoCollection->Add( pItem, pos );	
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
bool CviFilesCollection::Add( CviFileInfo * pItem, LPCTSTR key )
{
	return m_pFileInfoCollection->Add( pItem, key );	
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
bool CviFilesCollection::Remove( ULONG pos )
{
	return m_pFileInfoCollection->Remove( pos );
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
bool CviFilesCollection::Remove( LPCTSTR key )
{
	return m_pFileInfoCollection->Remove( key );
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
CviFileInfo * CviFilesCollection::Item( ULONG pos )
{
	return m_pFileInfoCollection->Item( pos );	
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
CviFileInfo * CviFilesCollection::Item( LPCTSTR key)
{
	return m_pFileInfoCollection->Item( key );	
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
void CviFilesCollection::Clear( )
{
	m_pFileInfoCollection->Clear();
}


/*************************************************************************************************
 *
 *
 *
 *************************************************************************************************/
ULONG CviFilesCollection::Count( )
{
	return m_pFileInfoCollection->Count();
}

/*************************************************************************************************
 *
 *	write collectiondata to trace
 *
 *************************************************************************************************/
void CviFilesCollection::DumpCollection()
{
	ULONG ulPos;

	for ( ulPos=0; ulPos < Count(); ulPos++)
	{
		VITRACE3(_T("%05d - %-90s Size: %d Byte\n"), ulPos, (LPCTSTR) Item(ulPos)->FullName(), Item(ulPos)->GetFileSize() );
	}
}
