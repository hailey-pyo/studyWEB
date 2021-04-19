package com.hailey.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileSave {
	public String save(String realPath, MultipartFile file) {
		File f = new File(realPath);
		if (!f.exists()) {
			f.mkdirs();
		}
		
		String fileName = UUID.randomUUID().toString();
		fileName = fileName + "_" + file.getOriginalFilename();
		
		//123.jpg
		
		f = new File(f, fileName);
		
		//1번
		try { 
			FileCopyUtils.copy(file.getBytes(), f);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		//2번
//		try { 
//			file.transferTo(f);
//		} catch (IllegalStateException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		
		return fileName;
	}
}
