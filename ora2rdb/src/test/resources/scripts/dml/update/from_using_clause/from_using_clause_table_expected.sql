/*UPDATE books b
    SET b.page_count = bpc.PAGE_COUNT
    [-unconvertible RS-242233 FROM book_page_count bpc]
WHERE b.ISBN = bpc.ISBN;*/

/*UPDATE books b
SET b.page_count = bpc.PAGE_COUNT
    [-unconvertible RS-242233 USING book_page_count bpc]
WHERE b.ISBN = bpc.ISBN;*/