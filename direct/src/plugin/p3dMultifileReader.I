/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file p3dMultifileReader.I
 * @author drose
 * @date 2009-06-15
 */

/**
 * Returns true if the reader is open, false otherwise.
 */
inline bool P3DMultifileReader::
is_open() const {
  return _is_open;
}

/**
 * Extracts an unsigned short from the file.
 */
inline unsigned int P3DMultifileReader::
read_uint16() {
  unsigned int a = _in.get();
  unsigned int b = _in.get();
  return (b << 8) | a;
}

/**
 * Extracts an unsigned long from the file.
 */
inline unsigned int P3DMultifileReader::
read_uint32() {
  unsigned int a = _in.get();
  unsigned int b = _in.get();
  unsigned int c = _in.get();
  unsigned int d = _in.get();
  return (d << 24) | (c << 16) | (b << 8) | a;
}

/**
 * Returns the byte position within the Multifile of the last byte that
 * contributes to this Subfile, either in the index record or in the subfile
 * data.
 */
inline size_t P3DMultifileReader::Subfile::
get_last_byte_pos() const {
  return max(_index_start + _index_length, _data_start + _data_length) - 1;
}

/**
 * Ownership of the X509 object is passed into the CertRecord; it will be
 * freed when the CertRecord destructs.
 */
inline P3DMultifileReader::CertRecord::
CertRecord(X509 *cert) :
  _cert(cert)
{
}

/**
 *
 */
inline P3DMultifileReader::CertRecord::
CertRecord(const P3DMultifileReader::CertRecord &copy) :
  _cert(X509_dup(copy._cert))
{
}

/**
 *
 */
inline P3DMultifileReader::CertRecord::
~CertRecord() {
  X509_free(_cert);
}
