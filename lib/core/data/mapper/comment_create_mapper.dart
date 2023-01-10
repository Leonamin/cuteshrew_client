import 'package:cuteshrew/core/data/dto/remote/comment_create_dto.dart';
import 'package:cuteshrew/core/data/mapper/mapper.dart';
import 'package:cuteshrew/core/domain/entity/comment_create_entity.dart';

class CommentCreateMapper
    extends Mapper<CommentCreateEntity, CommentCreateDTO> {
  @override
  CommentCreateDTO map(CommentCreateEntity object) {
    return CommentCreateDTO(comment: object.comment);
  }
}
