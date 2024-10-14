#include <stdlib.h>

#include <tree_sitter/api.h>

static inline TSNode *node_ptr(TSNode node) {
    TSNode *new_node = malloc(sizeof(TSNode));

    if (new_node) {
        *new_node = node;
    }

    return new_node;
}

TSNode *ts_tree_root_node_pointer(const TSTree *self) {
    TSNode *node = malloc(sizeof(TSNode));

    if (node) {
        *node = ts_tree_root_node(self);
    }

    return node;
}

TSTreeCursor *ts_tree_cursor_new_pointer(TSNode *node) {
    TSTreeCursor *cursor = malloc(sizeof(TSTreeCursor));

    if (cursor) {
        *cursor = ts_tree_cursor_new(*node);
    }

    return cursor;
}

void ts_tree_cursor_reset_pointer(TSTreeCursor *self, TSNode *node) {
  ts_tree_cursor_reset(self, *node);
}

TSNode *ts_tree_cursor_current_node_pointer(const TSTreeCursor *cursor) {
    TSNode *return_node = malloc(sizeof(TSNode));

    if (return_node) {
        *return_node = ts_tree_cursor_current_node(cursor);
    }

    return return_node;
}

void ts_query_cursor_exec_pointer(TSQueryCursor *self, const TSQuery *query, TSNode *node) {
  ts_query_cursor_exec(self, query, *node);
}

bool ts_node_is_named_pointer(TSNode *node) {
    return ts_node_is_named(*node);
}

TSPoint *ts_node_start_point_pointer(TSNode *node) {
    TSPoint *point = malloc(sizeof(TSPoint));

    if (point) {
        *point = ts_node_start_point(*node);
    }

    return point;
}

TSPoint* ts_node_end_point_pointer(TSNode *node) {
    TSPoint *point = malloc(sizeof(TSPoint));

    if (point) {
        *point = ts_node_end_point(*node);
    }

    return point;
}

const char *ts_node_type_pointer(TSNode *node) {
    return ts_node_type(*node);
}

TSSymbol ts_node_symbol_pointer(TSNode *self) {
  return ts_node_symbol(*self);
}

const TSLanguage *ts_node_language_pointer(TSNode *self) {
  return ts_node_language(*self);
}

const char *ts_node_grammar_type_pointer(TSNode *self) {
  return ts_node_grammar_type(*self);
}

TSSymbol ts_node_grammar_symbol_pointer(TSNode *self) {
  return ts_node_grammar_symbol(*self);
}

uint32_t ts_node_start_byte_pointer(TSNode *self) {
  return ts_node_start_byte(*self);
}

uint32_t ts_node_end_byte_pointer(TSNode *self) {
  return ts_node_end_byte(*self);
}

char *ts_node_string_pointer(TSNode *self) {
  return ts_node_string(*self);
}

bool ts_node_is_null_pointer(TSNode *self) {
  return ts_node_is_null(*self);
}

bool ts_node_is_missing_pointer(TSNode *self) {
  return ts_node_is_missing(*self);
}

bool ts_node_is_extra_pointer(TSNode *self) {
  return ts_node_is_extra(*self);
}

bool ts_node_has_changes_pointer(TSNode *self) {
  return ts_node_has_changes(*self);
}

bool ts_node_has_error_pointer(TSNode *self) {
  return ts_node_has_error(*self);
}

bool ts_node_is_error_pointer(TSNode *self) {
  return ts_node_is_error(*self);
}

TSStateId ts_node_parse_state_pointer(TSNode *self) {
  return ts_node_parse_state(*self);
}

TSStateId ts_node_next_parse_state_pointer(TSNode *self) {
  return ts_node_next_parse_state(*self);
}

TSNode *ts_node_parent_pointer(TSNode *self) {
  return node_ptr(ts_node_parent(*self));
}

TSNode *ts_node_child_containing_descendant_pointer(TSNode *self, TSNode *descendant) {
  return node_ptr(ts_node_child_containing_descendant(*self, *descendant));
}

TSNode *ts_node_child_pointer(TSNode *self, uint32_t child_index) {
  return node_ptr(ts_node_child(*self, child_index));
}

const char *ts_node_field_name_for_child_pointer(TSNode *self, uint32_t child_index) {
  return ts_node_field_name_for_child(*self, child_index);
}

uint32_t ts_node_child_count_pointer(TSNode *self) {
  return ts_node_child_count(*self);
}

TSNode *ts_node_named_child_pointer(TSNode *self, uint32_t child_index) {
  return node_ptr(ts_node_named_child(*self, child_index));
}

uint32_t ts_node_named_child_count_pointer(TSNode *self) {
  return ts_node_named_child_count(*self);
}

TSNode *ts_node_child_by_field_name_pointer(TSNode *self,
                                    const char *name,
                                    uint32_t name_length) {
  return node_ptr(ts_node_child_by_field_name(*self, name, name_length));
}

TSNode *ts_node_child_by_field_id_pointer(TSNode *self, TSFieldId field_id) {
  return node_ptr(ts_node_child_by_field_id(*self, field_id));
}

TSNode *ts_node_next_sibling_pointer(TSNode *self) {
  return node_ptr(ts_node_next_sibling(*self));
}

TSNode *ts_node_prev_sibling_pointer(TSNode *self) {
  return node_ptr(ts_node_prev_sibling(*self));
}


TSNode *ts_node_next_named_sibling_pointer(TSNode *self) {
  return node_ptr(ts_node_next_named_sibling(*self));
}

TSNode *ts_node_prev_named_sibling_pointer(TSNode *self) {
  return node_ptr(ts_node_prev_named_sibling(*self));
}

TSNode *ts_node_first_child_for_byte_pointer(TSNode *self, uint32_t byte) {
  return node_ptr(ts_node_first_child_for_byte(*self, byte));
}


TSNode *ts_node_first_named_child_for_byte_pointer(TSNode *self, uint32_t byte) {
  return node_ptr(ts_node_first_named_child_for_byte(*self, byte));
}

uint32_t ts_node_descendant_count_pointer(TSNode *self) {
  return ts_node_descendant_count(*self);
}

TSNode *ts_node_descendant_for_byte_range_pointer(TSNode *self, uint32_t start, uint32_t end) {
  return node_ptr(ts_node_descendant_for_byte_range(*self, start, end));
}

TSNode *ts_node_descendant_for_point_range_pointer(TSNode *self, TSPoint *start, TSPoint *end) {
  return node_ptr(ts_node_descendant_for_point_range(*self, *start, *end));
}

TSNode *ts_node_named_descendant_for_byte_range_pointer(TSNode *self, uint32_t start, uint32_t end) {
  return node_ptr(ts_node_named_descendant_for_byte_range(*self, start, end));
}

TSNode *ts_node_named_descendant_for_point_range_pointer(TSNode *self, TSPoint *start, TSPoint *end) {
  return node_ptr(ts_node_named_descendant_for_point_range(*self, *start, *end));
}

bool ts_node_eq_pointer(TSNode *self, TSNode *other) {
  return ts_node_eq(*self, *other);
}

void ts_query_cursor_set_point_range_pointer(TSQueryCursor *self, TSPoint *start_point, TSPoint *end_point) {
  return ts_query_cursor_set_point_range(self, *start_point, *end_point);
}

int64_t ts_tree_cursor_goto_first_child_for_point_pointer(TSTreeCursor *self, TSPoint *goal_point) {
  return ts_tree_cursor_goto_first_child_for_point(self, *goal_point);
}

TSNode *ts_tree_root_node_with_offset_pointer(const TSTree *self, uint32_t offset_bytes, TSPoint *offset_extent) {
  return node_ptr(ts_tree_root_node_with_offset(self, offset_bytes, *offset_extent));
}

// TODO: TSInput, TSLogger, TSQueryPredicateStep not implemented
