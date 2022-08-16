module vjvm

import os { abs_path, join_path_single, read_bytes, walk }
import szip { CompressionLevel, OpenMode, open }

interface Entry {
	read_class(class_name string) ?([]u8, &Entry)
	str() string
}

pub fn new_entry(path string) &Entry {
	return if path.contains(os.path_separator) {
		&Entry(new_composite_entry(path))
	} else if path.ends_with('*') {
		&Entry(new_wildcard_entry(path))
	} else if path.ends_with('.zip') || path.ends_with('.ZIP') || path.ends_with('.jar')
		|| path.ends_with('.JAR') {
		&Entry(new_zip_entry(path))
	} else {
		&Entry(new_dir_entry(path))
	}
}

struct DirEntry {
	abs_dir string
}

pub fn new_dir_entry(path string) DirEntry {
	return DirEntry{abs_path(path)}
}

pub fn (dir_entry &DirEntry) read_class(class_name string) ?([]u8, &Entry) {
	file_name := join_path_single(dir_entry.abs_dir, class_name)
	bytecode := read_bytes(file_name) or { return err }
	return bytecode, dir_entry
}

pub fn (dir_entry &DirEntry) str() string {
	return dir_entry.abs_dir
}

type CompositeEntry = []Entry

pub fn new_composite_entry(path string) CompositeEntry {
	mut composite_entry := []Entry{}

	for path_ in path.split(os.path_separator) {
		composite_entry << new_entry(path_)
	}

	return CompositeEntry(composite_entry)
}

pub fn (composite_entry &CompositeEntry) read_class(class_name string) ?([]u8, &Entry) {
	for entry in composite_entry {
		return entry.read_class(class_name) or { continue }
	}

	return error('Class not found: $class_name')
}

pub fn (composite_entry &CompositeEntry) str() string {
	mut segments := []string{cap: composite_entry.len}

	for entry in composite_entry {
		segments << entry.str()
	}

	return segments.join(os.path_separator)
}

pub fn new_wildcard_entry(path string) CompositeEntry {
	base_dir := path[..path.len - 1]
	mut composite_entry := []Entry{}

	walk := fn [mut composite_entry] (path_ string) {
		if path_.ends_with('.jar') || path_.ends_with('.JAR') {
			jar_entry := new_zip_entry(path_)
			composite_entry << jar_entry
		}
	}

	walk(base_dir, walk)

	return CompositeEntry(composite_entry)
}

pub struct ZipEntry {
	abs_path string
}

pub fn new_zip_entry(path string) ZipEntry {
	return ZipEntry{abs_path(path)}
}

pub fn (zip_entry &ZipEntry) read_class(class_name string) ?([]u8, &Entry) {
	mut zip := open(zip_entry.abs_path, CompressionLevel.best_speed, OpenMode.read_only)?

	defer {
		zip.close()
	}

	zip.open_entry(class_name)?

	unsafe {
		data := zip.read_entry() or { return error('Class not found: $class_name') }
		tmp_str := tos(data, int(zip.size()))

		return tmp_str.bytes(), zip_entry
	}
}

pub fn (zip_entry &ZipEntry) str() string {
	return zip_entry.abs_path
}
